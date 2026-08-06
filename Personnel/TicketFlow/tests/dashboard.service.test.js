import { jest } from '@jest/globals'; // <-- L'import manquant
import * as dashboardService from '../src/services/dashboard.service.js';
import dashboardRepository from '../src/repositories/dashboard.repository.js';

describe('Dashboard Service', () => {

  beforeEach(() => {
    jest.spyOn(dashboardRepository, 'getTicketsStats');
    jest.spyOn(dashboardRepository, 'getTechnicianStats'); // Nouveau mock
  });

  afterEach(() => {
    jest.restoreAllMocks();
  });

  test('Must calculate resolution rate correctly if tickets are resolved', async () => {
    dashboardRepository.getTicketsStats.mockResolvedValue({
      byStatus: [
        { _id: 'Resolved', count: 5 },
        { _id: 'Open', count: 5 }
      ],
      hotspots: [],
      activeByPriority: [],
      zombies: [{ count: 0 }]
    });

    const result = await dashboardService.getStats('tickets');

    expect(result.overview.total).toBe(10);
    expect(result.overview.resolved).toBe(5);
    expect(result.overview.resolutionRate).toBe(50);
  });

  test('Should return 0%resolution rate if total tickets is 0', async () => {
    dashboardRepository.getTicketsStats.mockResolvedValue({
      byStatus: [],
      hotspots: [],
      activeByPriority: [],
      zombies: [{ count: 0 }]
    });
    
    const result = await dashboardService.getStats('tickets');
    expect(result.overview.resolutionRate).toBe(0);
  });

  // NOUVEAU TEST POUR LES TECHNICIENS
  test('Should return formatted technician statistics when type is "technicians"', async () => {
    dashboardRepository.getTechnicianStats.mockResolvedValue({
      global: [{ total: 5, level1: 2, level2: 2, level3: 1 }],
      workload: []
    });

    const result = await dashboardService.getStats('technicians');

    expect(result.type).toBe('technicians');
    expect(result.overview.total).toBe(5);
    expect(result.overview.breakdown.level3).toBe(1);
  });
});