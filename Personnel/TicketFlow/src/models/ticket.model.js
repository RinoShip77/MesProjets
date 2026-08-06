import mongoose from 'mongoose';

const ticketSchema = new mongoose.Schema({
  title: { type: String, required: true, maxlength: 100 },
  description: { type: String, required: true },
  status: { type: String, enum: ['Open', 'In progress', 'Resolved', 'Closed'], default: 'Open' },
  originDepartment: { type: String },
  priority: { type: Number, min: 1, max: 5, default: 3 },

  //#region Exercice 33 : Les Relations et Jointures (Populate)
  assignedTo: { type: mongoose.Schema.Types.ObjectId, ref: 'Technician' },
  //#endregion

  //#region Exercice 34 : Les Sous-documents et l'opérateur $push
  notes: [{
    text: { type: String, required: true },
    technician: { type: mongoose.Schema.Types.ObjectId, ref: 'Technician' },
    date: { type: Date, default: Date.now }
  }],
  //#endregion
}, {
  versionKey: false,
  timestamps: true
});

export default mongoose.model('Ticket', ticketSchema);