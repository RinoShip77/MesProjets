import Ticket from '../models/ticket.model.js';
import Technician from '../models/technician.model.js';

export default async () => {
    try {
        const ticketsCount = await Ticket.countDocuments();

        if (ticketsCount === 0) {
            console.log('[Seed] Database is empty. Injecting tickets ...');

            const technicianCount = await Technician.countDocuments();
            
            // 1. Declaration outside the if block
            let savedTechnicians; 

            if (technicianCount === 0) {
                console.log('[Seed] Database is empty. Injecting technicians ...');

                const initialTechnician = [
                    { name: "Alice Dupont", email: "alice.dupont@ticketflow.com", password: "password123", level: 1 },
                    { name: "Pierre Paul", email: "pierre.paul@ticketflow.com", password: "password123", level: 2 },
                    { name: "Marie Curie", email: "marie.curie@ticketflow.com", password: "password123", level: 3 },
                    { name: "Jean Martin", email: "jean.martin@ticketflow.com", password: "password123", level: 2 },
                    { name: "Sophie Lambert", email: "sophie.lambert@ticketflow.com", password: "password123", level: 1 }
                ];

                // 2. On utilise 'create' au lieu de 'insertMany' pour déclencher le pre('save') de bcrypt
                savedTechnicians = await Technician.create(initialTechnician);
                console.log('[Seed] Technicians injected successfully.');
            } else {
                // 3. If the technicians already exist, we recover them!
                console.log('[Seed] Technicians already exist. Fetching them...');
                savedTechnicians = await Technician.find();
            }

            // 4. At this point, savedTechnicians is guaranteed to exist and contain the _id
            const initialTickets = [
                { title: "Serveur courriel hors ligne", description: "Impossible d'envoyer ou de recevoir des courriels depuis 8h00.", status: "Open", originDepartment: "TI", priority: 5, assignedTo: savedTechnicians[0]._id },
                { title: "Demande de nouveau moniteur", description: "Besoin d'un 2ème écran pour le poste 42.", status: "In progress", originDepartment: "Ressources Humaines", priority: 2, assignedTo: savedTechnicians[1]._id },
                { title: "Mot de passe oublié", description: "Réinitialisation du mot de passe pour l'intranet.", status: "Closed", originDepartment: "Comptabilité", priority: 1, assignedTo: savedTechnicians[2]._id },
                { title: "Problème d'accès à l'imprimante", description: "Impossible d'imprimer depuis le poste 15.", status: "In progress", originDepartment: "Support Technique", priority: 4, assignedTo: savedTechnicians[3]._id },
                { title: "Demande de formation sur le nouveau logiciel", description: "Besoin de formation sur le nouveau logiciel.", status: "Resolved", originDepartment: "Equipe de direction", priority: 3, assignedTo: savedTechnicians[4]._id }
            ];

            function generateRandomTickets(source, quantite = 50) {
                const choix = {
                    titles: source.map(t => t.title),
                    descriptions: source.map(t => t.description),
                    statuses: source.map(t => t.status),
                    departments: source.map(t => t.originDepartment),
                    priorities: source.map(t => t.priority),
                    assignedTo: source.map(t => t.assignedTo)
                };

                const pick = (list) => list[Math.floor(Math.random() * list.length)];

                return Array.from({ length: quantite }, () => ({
                    title: pick(choix.titles),
                    description: pick(choix.descriptions),
                    status: pick(choix.statuses),
                    originDepartment: pick(choix.departments),
                    priority: pick(choix.priorities),
                    assignedTo: pick(choix.assignedTo)
                }));
            }

            const generatedTickets = generateRandomTickets(initialTickets, 50);

            await Ticket.insertMany(generatedTickets);
            console.log('[Seed] Tickets injected successfully.');
        } else {
            console.log(`[Seed] Database already contains ${ticketsCount} tickets. Ignored.`);
        }
    } catch (erreur) {
        console.error('[Seed] Error while injecting data:', erreur.message);
        process.exit(1);
    }
};