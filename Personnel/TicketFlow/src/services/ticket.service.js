import ticketRepository from '../repositories/ticket.repository.js';

export const getAll = async (queryFilters = {}) => {
  const { pageStr, limitStr, status, search, sortBy, orderBy } = queryFilters;

  const page = parseInt(pageStr) || 1;
  const limit = parseInt(limitStr) || 10;
  const filter = {};

  if (status) filter.status = { $regex: new RegExp(`^${status}$`, 'i') };
  if (search) filter.$or = [{ title: { $regex: new RegExp(search, 'i') } }];

  const sortedBy = sortBy || 'createdAt';
  const order = orderBy === 'desc' ? -1 : 1;
  const sort = { [sortedBy]: order };

  return await ticketRepository.findAll(page, limit, filter, sort);
};

export const getOne = async (id) => await ticketRepository.findById(id);

export const create = async (data) => {
  if (Array.isArray(data)) {
    try {
      return await ticketRepository.createMany(data);
    } catch (error) {
      if (error.name === 'BulkWriteError' && error.insertedDocs) {
        return { message: "Partial success", insertedCount: error.insertedDocs.length, errors: error.writeErrors };
      }
      throw error;
    }
  }
  return await ticketRepository.createOne(data);
};

export const update = async (data) => {
  if (data.ids && Array.isArray(data.ids)) {
    return await ticketRepository.updateMany(data.ids, data.updateData);
  }
  return await ticketRepository.updateOne(data.id, data.updateData);
};

export const remove = async (data) => {
  if (data.ids && Array.isArray(data.ids)) {
    return await ticketRepository.deleteMany(data.ids);
  }
  return await ticketRepository.deleteOne(data.id);
};

export const addNote = async (id, noteData) => {
  return await ticketRepository.addNote(id, noteData);
};