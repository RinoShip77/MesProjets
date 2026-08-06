import Technician from '../models/technician.model.js';

class TechnicianRepository {
  async findAll() { return await Technician.find(); }
  async findById(id) { return await Technician.findById(id); }

  async createOne(data) { return await Technician.create(data); }
  async createMany(dataArray) {
    return await Technician.insertMany(dataArray, { ordered: false });
  }

  async updateOne(id, updateData) {
    return await Technician.findByIdAndUpdate(id, { $set: updateData }, { new: true, runValidators: true });
  }
  async updateMany(ids, updateData) {
    return await Technician.updateMany({ _id: { $in: ids } }, { $set: updateData }, { runValidators: true });
  }

  async deleteOne(id) { return await Technician.findByIdAndDelete(id); }
  async deleteMany(ids) { return await Technician.deleteMany({ _id: { $in: ids } }); }

  // Ajoute ceci dans ta classe TechnicianRepository
  async findByEmailForLogin(email) {
    return await Technician.findOne({ email }).select('+password');
  }
}

export default new TechnicianRepository();