import express from 'express';
import * as technicianController from '../controllers/technician.controller.js';
import { validateRequest } from '../middlewares/validate.middleware.js';
import { authenticateToken } from '../middlewares/auth.middleware.js';
import {
  createTechnicianSchema,
  updateTechnicianSchema,
  deleteBulkSchema
} from '../validators/technician.validator.js';

const router = express.Router();

/**
 * @swagger
 * tags:
 *   name: Technicians
 *   description: Gestion des techniciens (CRUD & Bulk)
 */

/**
 * @swagger
 * /technicians:
 *   get:
 *     summary: Récupérer tous les techniciens
 *     tags: [Technicians]
 *     responses:
 *       200:
 *         description: Liste des techniciens retournée.
 */
router.get('/', technicianController.getAll);

/**
 * @swagger
 * /technicians/{id}:
 *   get:
 *     summary: Récupérer un technicien par ID
 *     tags: [Technicians]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *     responses:
 *       200:
 *         description: Détails du technicien.
 *       404:
 *         description: Technicien non trouvé.
 */
router.get('/:id', technicianController.getOne);

/**
 * @swagger
 * /technicians:
 *   post:
 *     summary: Créer un ou plusieurs techniciens (Bulk)
 *     tags: [Technicians]
 *     security:
 *       - BearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             example: { "name": "Jean", "email": "jean@tf.com", "password": "pwd", "level": 2 }
 *     responses:
 *       201:
 *         description: Création réussie.
 *       207:
 *         description: Succès partiel (BulkWriteError).
 *       400:
 *         description: Erreur de validation Joi.
 */
router.post('/', authenticateToken, validateRequest(createTechnicianSchema), technicianController.create);

/**
 * @swagger
 * /technicians:
 *   patch:
 *     summary: Mettre à jour plusieurs techniciens (Bulk)
 *     tags: [Technicians]
 *     security:
 *       - BearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             example: { "ids": ["6a..."], "updateData": { "level": 3 } }
 *     responses:
 *       200:
 *         description: Mise à jour réussie.
 */
router.patch('/', authenticateToken, validateRequest(updateTechnicianSchema), technicianController.update);

/**
 * @swagger
 * /technicians/{id}:
 *   patch:
 *     summary: Mettre à jour un technicien spécifique
 *     tags: [Technicians]
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
 *             example: { "level": 3 }
 *     responses:
 *       200:
 *         description: Mise à jour réussie.
 */
router.patch('/:id', authenticateToken, validateRequest(updateTechnicianSchema), technicianController.update);

/**
 * @swagger
 * /technicians:
 *   delete:
 *     summary: Supprimer plusieurs techniciens (Bulk)
 *     tags: [Technicians]
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
router.delete('/', authenticateToken, validateRequest(deleteBulkSchema), technicianController.remove);

/**
 * @swagger
 * /technicians/{id}:
 *   delete:
 *     summary: Supprimer un technicien spécifique
 *     tags: [Technicians]
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
router.delete('/:id', authenticateToken, technicianController.remove);

export default router;