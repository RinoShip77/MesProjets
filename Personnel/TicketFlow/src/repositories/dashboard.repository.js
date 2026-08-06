import Ticket from '../models/ticket.model.js';
import Technician from '../models/technician.model.js';

class DashboardRepository {
  
  async getTicketsStats() {
    // Calcul de la date pour les "Zombies" (tickets inactifs depuis 7 jours)
    const sevenDaysAgo = new Date();
    sevenDaysAgo.setDate(sevenDaysAgo.getDate() - 7);

    const stats = await Ticket.aggregate([
      {
        $facet: {
          // 1. Répartition globale par statut
          "byStatus": [
            { $group: { _id: "$status", count: { $sum: 1 } } }
          ],
          
          // 2. Matrice de priorité (Uniquement les tickets ouverts/en cours)
          "activeByPriority": [
            { $match: { status: { $in: ["Open", "In progress"] } } },
            { $group: { _id: "$priority", count: { $sum: 1 } } },
            { $sort: { _id: -1 } } // Trie par priorité décroissante (5 en premier)
          ],
          
          // 3. Points chauds par département
          "hotspots": [
            { $group: { _id: "$originDepartment", count: { $sum: 1 } } },
            { $sort: { count: -1 } } // Le département avec le plus de tickets en premier
          ],

          // 4. Les Zombies (Oubliés)
          "zombies": [
            { 
              $match: { 
                status: { $nin: ["Resolved", "Closed"] },
                updatedAt: { $lt: sevenDaysAgo }
              } 
            },
            { $count: "count" }
          ]
        }
      }
    ]);

    return stats[0];
  }

  async getTechnicianStats() {
    const stats = await Technician.aggregate([
      {
        // 1. Jointure avec la collection des tickets
        // Note : MongoDB met le nom de la collection au pluriel et en minuscules par défaut ('tickets')
        $lookup: {
          from: "tickets", 
          localField: "_id",
          foreignField: "assignedTo",
          as: "assignedTickets"
        }
      },
      {
        $facet: {
          // 2A. Répartition globale par niveau (comme avant)
          "global": [
            {
              $group: {
                _id: null,
                total: { $sum: 1 },
                level1: { $sum: { $cond: [{ $eq: ["$level", 1] }, 1, 0] } },
                level2: { $sum: { $cond: [{ $eq: ["$level", 2] }, 1, 0] } },
                level3: { $sum: { $cond: [{ $eq: ["$level", 3] }, 1, 0] } }
              }
            }
          ],
          // 2B. Charge de travail par technicien
          "workload": [
            {
              $project: {
                name: 1,
                level: 1,
                email: 1,
                // Compte les tickets "Open" ou "In progress"
                activeTickets: {
                  $size: {
                    $filter: {
                      input: "$assignedTickets",
                      as: "ticket",
                      cond: { $in: ["$$ticket.status", ["Open", "In progress"]] }
                    }
                  }
                },
                // Compte les tickets "Resolved"
                resolvedTickets: {
                  $size: {
                    $filter: {
                      input: "$assignedTickets",
                      as: "ticket",
                      cond: { $eq: ["$$ticket.status", "Resolved"] }
                    }
                  }
                }
              }
            },
            { $sort: { activeTickets: -1 } } // Trie par le technicien le plus occupé
          ]
        }
      }
    ]);

    return stats[0];
  }
}

export default new DashboardRepository();