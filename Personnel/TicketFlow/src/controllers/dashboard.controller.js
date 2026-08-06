import * as dashboardService from '../services/dashboard.service.js';
import { asyncHandler } from '../utils/asyncHandler.js';

export const getStats = asyncHandler(async (req, res) => {
  // On récupère le paramètre ?type= (par défaut on considérera les tickets)
  const { type } = req.query;

  const stats = await dashboardService.getStats(type);
  res.status(200).json(stats);
});