import { Router } from 'express';
import { authenticateToken } from '../middlewares/auth.middleware.js';
import { login, logout } from '../controllers/auth.controller.js';

const router = Router();

/**
 * @swagger
 * tags:
 *   name: Auth
 *   description: Gestion des sessions techniciens
 */

/**
 * @swagger
 * /auth/login:
 *   post:
 *     summary: Authentifier un technicien
 *     tags: [Auth]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required: [email, password]
 *             properties:
 *               email:
 *                 type: string
 *                 example: alice.dupont@ticketflow.com
 *               password:
 *                 type: string
 *                 example: password123
 *     responses:
 *       200:
 *         description: Connexion réussie, retourne le token JWT et les infos utilisateur.
 *       400:
 *         description: Email ou mot de passe manquant.
 *       401:
 *         description: Identifiants invalides.
 */
router.post('/login', login);

/**
 * @swagger
 * /auth/logout:
 *   post:
 *     summary: Déconnecter le technicien courant
 *     tags: [Auth]
 *     security:
 *       - BearerAuth: []
 *     responses:
 *       200:
 *         description: Déconnexion réussie.
 *       401:
 *         description: Non autorisé, token manquant ou invalide.
 */
router.post('/logout', authenticateToken, logout);

export default router;