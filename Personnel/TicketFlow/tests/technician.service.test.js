import { jest } from '@jest/globals';
import * as technicianService from '../src/services/technician.service.js';
import technicianRepository from '../src/repositories/technician.repository.js';

describe('Technician Service', () => {
  
  afterEach(() => {
    jest.restoreAllMocks();
  });

  test('Must trigger createOne if sending a single object', async () => {
    // ARRANGE
    const mockData = { name: 'Olivier' };
    const spyCreateOne = jest.spyOn(technicianRepository, 'createOne').mockResolvedValue({ _id: '123', ...mockData });
    
    // ACT
    const result = await technicianService.create(mockData);
    
    // ASSERT
    expect(spyCreateOne).toHaveBeenCalledWith(mockData);
    expect(result.name).toBe('Olivier');
  });

  test('Must trigger createMany if sending an array (Bulk)', async () => {
    // ARRANGE
    const mockArray = [{ name: 'Tech 1' }, { name: 'Tech 2' }];
    const spyCreateMany = jest.spyOn(technicianRepository, 'createMany').mockResolvedValue(mockArray);
    
    // ACT
    const result = await technicianService.create(mockArray);
    
    // ASSERT
    expect(spyCreateMany).toHaveBeenCalledWith(mockArray);
    expect(result.length).toBe(2);
  });

  test('Should catch a BulkWriteError and return partial success', async () => {
    // ARRANGE
    const mockArray = [{ name: 'Tech 1' }];
    const mockError = new Error('Erreur de BD');
    mockError.name = 'BulkWriteError';
    mockError.insertedDocs = [{ name: 'Tech 1' }]; // Simulation des documents réussis
    mockError.writeErrors = ['Erreur sur le Tech 2'];
    
    jest.spyOn(technicianRepository, 'createMany').mockRejectedValue(mockError);

    // ACT
    const result = await technicianService.create(mockArray);

    // ASSERT
    expect(result.message).toBe('Partial success');
    expect(result.insertedCount).toBe(1);
  });
});