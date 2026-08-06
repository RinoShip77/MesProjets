import dashboardRepository from '../repositories/dashboard.repository.js';

export const getStats = async (type = 'tickets') => {
  
  if (type === 'technicians') {
    const rawData = await dashboardRepository.getTechnicianStats();
    
    // Sécurisation au cas où la collection serait vide
    const globalStats = rawData.global[0] || { total: 0, level1: 0, level2: 0, level3: 0 };
    const workload = rawData.workload || [];

    // Isoler les techniciens disponibles (0 ticket actif)
    const availableTechs = workload
      .filter(tech => tech.activeTickets === 0)
      .map(tech => ({ name: tech.name, level: tech.level }));

    return {
      type: 'technicians',
      overview: {
        total: globalStats.total,
        breakdown: {
          level1: globalStats.level1,
          level2: globalStats.level2,
          level3: globalStats.level3
        },
        availableCount: availableTechs.length
      },
      readyForDispatch: availableTechs, // Pour assignation rapide
      workloadMatrix: workload // Pour l'affichage d'un tableau de bord complet
    };
  }

  // Logique pour les tickets avec les stats avancées
  const rawData = await dashboardRepository.getTicketsStats();

  // Helper pour extraire une valeur d'un tableau généré par $facet
  const getCount = (array, id) => {
    const item = array.find(x => x._id === id);
    return item ? item.count : 0;
  };

  const resolved = getCount(rawData.byStatus, 'Resolved');
  const closed = getCount(rawData.byStatus, 'Closed');
  const open = getCount(rawData.byStatus, 'Open');
  const inProgress = getCount(rawData.byStatus, 'In progress');
  
  const total = resolved + closed + open + inProgress;
  const resolutionRate = total > 0 ? Math.round(((resolved + closed) / total) * 100) : 0;

  // Formatage des hotspots (départements)
  const departments = rawData.hotspots.map(h => ({
    department: h._id || 'Not specified',
    count: h.count
  }));

  // Formatage de la matrice de priorité active
  const priorityMatrix = rawData.activeByPriority.map(p => ({
    priorityLevel: p._id,
    activeTickets: p.count
  }));

  return {
    type: 'tickets',
    overview: {
      total,
      open,
      inProgress,
      resolved,
      closed,
      resolutionRate
    },
    criticality: {
      priorityMatrix,
      zombieTickets: rawData.zombies[0]?.count || 0
    },
    departments
  };
};