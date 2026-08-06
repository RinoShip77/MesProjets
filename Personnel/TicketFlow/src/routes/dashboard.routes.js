import express from 'express';
import * as dashboardController from '../controllers/dashboard.controller.js';

const router = express.Router();

/**
 * @swagger
 * tags:
 *   name: Dashboard
 *   description: Statistiques et métriques globales
 */

/**
 * @swagger
 * /dashboard:
 *   get:
 *     summary: Obtenir les statistiques du tableau de bord
 *     tags: [Dashboard]
 *     security:
 *       - BearerAuth: []
 *     parameters:
 *       - in: query
 *         name: type
 *         schema:
 *           type: string
 *           enum: [tickets, technicians]
 *           default: tickets
 *         description: Le type d'entité pour lequel générer les statistiques.
 *     responses:
 *       200:
 *         description: Statistiques calculées et retournées avec succès.
 *       401:
 *         description: Non autorisé.
 */
router.get('/', dashboardController.getStats);

export default router;