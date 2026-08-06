import * as technicianService from '../services/technician.service.js';
import { asyncHandler } from '../utils/asyncHandler.js';

export const getAll = asyncHandler(async (req, res) => {
  const technicians = await technicianService.getAll();
  res.status(200).json(technicians);
});

export const getOne = asyncHandler(async (req, res) => {
  const tech = await technicianService.getOne(req.params.id);
  if (!tech) {
    const error = new Error('Not found');
    error.statusCode = 404;
    throw error;
  }
  res.status(200).json(tech);
});

export const create = asyncHandler(async (req, res) => {
  const result = await technicianService.create(req.body);
  if (result.message === "Partial success") {
    return res.status(207).json(result);
  }
  res.status(201).json(result);
});

export const update = asyncHandler(async (req, res) => {
  const payload = req.params.id ? { id: req.params.id, updateData: req.body } : req.body;
  const updated = await technicianService.update(payload);
  res.status(200).json(updated);
});

export const remove = asyncHandler(async (req, res) => {
  const payload = req.params.id ? { id: req.params.id } : req.body;
  const deleted = await technicianService.remove(payload);
  res.status(200).json(deleted);
});