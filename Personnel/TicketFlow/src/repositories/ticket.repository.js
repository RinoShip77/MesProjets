import Ticket from '../models/ticket.model.js';

class TicketRepository {
  async findAll(page, limit, filter, sort) {
    const skip = (page - 1) * limit;
    return {
      total: await Ticket.countDocuments(filter),
      tickets: await Ticket.find(filter)
        .sort(sort)
        .skip(skip)
        .limit(limit)
        .populate('assignedTo', 'email name level')
        .populate('notes.technician', 'email name level')
    };
  }

  async findById(id) {
    return await Ticket.findById(id).populate('assignedTo').populate('notes.technician');
  }

  async createOne(data) { return await Ticket.create(data); }
  async createMany(dataArray) {
    return {
      total: await Ticket.countDocuments(),
      tickets: await Ticket.insertMany(dataArray, { ordered: false })
    };
  }

  async updateOne(id, updateData) {
    return await Ticket.findByIdAndUpdate(id, { $set: updateData }, { returnDocument: 'after', runValidators: true });
  }
  async updateMany(ids, updateData) {
    return await Ticket.updateMany({ _id: { $in: ids } }, { $set: updateData }, { runValidators: true });
  }

  async deleteOne(id) { return await Ticket.findByIdAndDelete(id); }
  async deleteMany(ids) { return await Ticket.deleteMany({ _id: { $in: ids } }); }

  // Opération spécifique pour les sous-documents
  async addNote(id, noteData) {
    return await Ticket.findByIdAndUpdate(
      id,
      { $push: { notes: noteData } },
      { new: true, runValidators: true }
    ).populate('notes.technician');
  }
}

export default new TicketRepository();