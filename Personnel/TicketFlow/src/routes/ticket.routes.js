import express from 'express';
import * as ticketController from '../controllers/ticket.controller.js';
import { validateRequest } from '../middlewares/validate.middleware.js';
import { authenticateToken } from '../middlewares/auth.middleware.js';
import {
  createTicketSchema,
  updateTicketSchema,
  deleteBulkSchema,
  addNoteSchema
} from '../validators/ticket.validator.js';

const router = express.Router();

/**
 * @swagger
 * tags:
 *   name: Tickets
 *   description: Gestion des tickets de support
 */

/**
 * @swagger
 * /tickets:
 *   get:
 *     summary: Obtenir la liste paginée et filtrée des tickets
 *     tags: [Tickets]
 *     parameters:
 *       - in: query
 *         name: page
 *         schema:
 *           type: integer
 *           default: 1
 *       - in: query
 *         name: limit
 *         schema:
 *           type: integer
 *           default: 10
 *       - in: query
 *         name: status
 *         schema:
 *           type: string
 *           enum: [Open, In progress, Resolved, Closed]
 *       - in: query
 *         name: search
 *         description: Recherche Regex sur le titre
 *         schema:
 *           type: string
 *       - in: query
 *         name: sortBy
 *         schema:
 *           type: string
 *           default: createdAt
 *       - in: query
 *         name: orderBy
 *         schema:
 *           type: string
 *           enum: [asc, desc]
 *           default: asc
 *     responses:
 *       200:
 *         description: Liste retournée.
 */
router.get('/', ticketController.getAll);

/**
 * @swagger
 * /tickets/{id}:
 *   get:
 *     summary: Obtenir les détails d'un ticket
 *     tags: [Tickets]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *     responses:
 *       200:
 *         description: Détails du ticket.
 */
router.get('/:id', ticketController.getOne);

/**
 * @swagger
 * /tickets:
 *   post:
 *     summary: Créer un ou plusieurs tickets
 *     tags: [Tickets]
 *     security:
 *       - BearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             example: { "title": "Panne réseau", "description": "Plus de VPN", "priority": 5, "status": "Open" }
 *     responses:
 *       201:
 *         description: Création réussie.
 */
router.post('/', authenticateToken, validateRequest(createTicketSchema), ticketController.create);

/**
 * @swagger
 * /tickets:
 *   patch:
 *     summary: Mettre à jour plusieurs tickets (Bulk)
 *     tags: [Tickets]
 *     security:
 *       - BearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             example: { "ids": ["6a..."], "updateData": { "status": "Resolved" } }
 *     responses:
 *       200:
 *         description: Mise à jour en lot réussie.
 */
router.patch('/', authenticateToken, validateRequest(updateTicketSchema), ticketController.update);

/**
 * @swagger
 * /tickets/{id}:
 *   patch:
 *     summary: Mettre à jour un ticket spécifique
 *     tags: [Tickets]
 *     security:
 *       - BearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             example: { "status": "In progress" }
 *     responses:
 *       200:
 *         description: Mise à jour réussie.
 */
router.patch('/:id', authenticateToken, validateRequest(updateTicketSchema), ticketController.update);

/**
 * @swagger
 * /tickets:
 *   delete:
 *     summary: Supprimer plusieurs tickets (Bulk)
 *     tags: [Tickets]
 *     security:
 *       - BearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             example: { "ids": ["6a..."] }
 *     responses:
 *       200:
 *         description: Suppression en lot réussie.
 */
router.delete('/', authenticateToken, validateRequest(deleteBulkSchema), ticketController.remove);

/**
 * @swagger
 * /tickets/{id}:
 *   delete:
 *     summary: Supprimer un ticket spécifique
 *     tags: [Tickets]
 *     security:
 *       - BearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *     responses:
 *       200:
 *         description: Suppression réussie.
 */
router.delete('/:id', authenticateToken, ticketController.remove);

/**
 * @swagger
 * /tickets/{id}/notes:
 *   post:
 *     summary: Ajouter une note à un ticket
 *     tags: [Tickets]
 *     security:
 *       - BearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             example: { "text": "Diagnostic en cours..." }
 *     responses:
 *       200:
 *         description: Note ajoutée avec succès.
 */
router.post('/:id/notes', authenticateToken, validateRequest(addNoteSchema), ticketController.addNote);

export default router;