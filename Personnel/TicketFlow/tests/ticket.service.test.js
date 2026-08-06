import { jest } from '@jest/globals';
import * as ticketService from '../src/services/ticket.service.js';
import ticketRepository from '../src/repositories/ticket.repository.js';

describe('Ticket Service', () => {
  
  afterEach(() => {
    jest.restoreAllMocks();
  });

  test('Should apply default paging and sorting values ​​if query is empty', async () => {
    // ARRANGE
    const spyFindAll = jest.spyOn(ticketRepository, 'findAll').mockResolvedValue([]);

    // ACT
    await ticketService.getAll({});

    // ASSERT
    // page 1, limit 10, filtre vide {}, tri par createdAt croissant
    expect(spyFindAll).toHaveBeenCalledWith(1, 10, {}, { createdAt: 1 });
  });

  test('Must construct a Regex search filter if the search parameter is present', async () => {
    // ARRANGE
    const spyFindAll = jest.spyOn(ticketRepository, 'findAll').mockResolvedValue([]);

    // ACT
    await ticketService.getAll({ search: 'Panne' });

    // ASSERT
    const appelArgs = spyFindAll.mock.calls[0];
    const filtres = appelArgs[2]; // Le 3e argument est l'objet 'filter'
    
    expect(filtres.$or).toBeDefined();
    // On vérifie que la Regex a bien été générée pour le champ title
    expect(filtres.$or[0].title.$regex).toBeInstanceOf(RegExp);
  });

  test('Must construct a descending sort if orderBy=desc is provided', async () => {
    // ARRANGE
    const spyFindAll = jest.spyOn(ticketRepository, 'findAll').mockResolvedValue([]);

    // ACT
    await ticketService.getAll({ sortBy: 'priority', orderBy: 'desc' });

    // ASSERT
    const appelArgs = spyFindAll.mock.calls[0];
    const sortParams = appelArgs[3]; // Le 4e argument est l'objet 'sort'
    
    expect(sortParams).toEqual({ priority: -1 });
  });
  
  test('Must handle partial batch update (Bulk PATCH)', async () => {
    // ARRANGE
    const bulkPayload = { ids: ['id1', 'id2'], updateData: { status: 'Resolved' } };
    const spyUpdateMany = jest.spyOn(ticketRepository, 'updateMany').mockResolvedValue({ modifiedCount: 2 });
    
    // ACT
    await ticketService.update(bulkPayload);
    
    // ASSERT
    expect(spyUpdateMany).toHaveBeenCalledWith(['id1', 'id2'], { status: 'Resolved' });
  });
});