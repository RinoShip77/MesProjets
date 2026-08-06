import * as ticketService from '../services/ticket.service.js';
import { asyncHandler } from '../utils/asyncHandler.js';

export const getAll = asyncHandler(async (req, res) => {
  const filters = {
    pageStr: req.query.page,
    limitStr: req.query.limit,
    status: req.query.status,
    search: req.query.search,
    sortBy: req.query.sortBy,
    orderBy: req.query.orderBy
  };
  const tickets = await ticketService.getAll(filters);
  res.status(200).json(tickets);
});

export const getOne = asyncHandler(async (req, res) => {
  const ticket = await ticketService.getOne(req.params.id);
  if (!ticket) {
    const error = new Error('Not found');
    error.statusCode = 404;
    throw error;
  }
  res.status(200).json(ticket);
});

export const create = asyncHandler(async (req, res) => {
  const result = await ticketService.create(req.body);
  if (result.message === "Partial success") {
    return res.status(207).json(result);
  }
  res.status(201).json(result);
});

export const update = asyncHandler(async (req, res) => {
  const payload = req.params.id ? { id: req.params.id, updateData: req.body } : req.body;
  const updated = await ticketService.update(payload);
  res.status(200).json(updated);
});

export const remove = asyncHandler(async (req, res) => {
  const payload = req.params.id ? { id: req.params.id } : req.body;
  const deleted = await ticketService.remove(payload);
  res.status(200).json(deleted);
});

export const addNote = asyncHandler(async (req, res) => {
  // Le middleware 'validateRequest' a déjà vérifié que req.body.text est valide.
  // On construit l'objet de la note de façon sécuritaire avec l'identité du token.
  const noteData = {
    text: req.body.text,
    technician: req.technician.id // Injecté par ton authenticateToken middleware
  };

  const updatedTicket = await ticketService.addNote(req.params.id, noteData);
  
  if (!updatedTicket) {
    const error = new Error('Ticket not found');
    error.statusCode = 404;
    throw error;
  }
  
  res.status(201).json(updatedTicket);
});