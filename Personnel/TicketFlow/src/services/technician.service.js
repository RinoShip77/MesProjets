import technicianRepository from '../repositories/technician.repository.js';

export const getAll = async () => await technicianRepository.findAll();
export const getOne = async (id) => await technicianRepository.findById(id);

export const create = async (data) => {
  if (Array.isArray(data)) {
    try {
      return await technicianRepository.createMany(data);
    } catch (error) {
      if (error.name === 'BulkWriteError' && error.insertedDocs) {
        return { message: "Partial success", insertedCount: error.insertedDocs.length, errors: error.writeErrors };
      }
      throw error;
    }
  }
  return await technicianRepository.createOne(data);
};

export const update = async (data) => {
  if (data.ids && Array.isArray(data.ids)) {
    return await technicianRepository.updateMany(data.ids, data.updateData);
  }
  return await technicianRepository.updateOne(data.id, data.updateData);
};

export const remove = async (data) => {
  if (data.ids && Array.isArray(data.ids)) {
    return await technicianRepository.deleteMany(data.ids);
  }
  return await technicianRepository.deleteOne(data.id);
};