import jwt from 'jsonwebtoken';
import technicianRepository from '../repositories/technician.repository.js';
import { env } from '../config/env.config.js';
import { asyncHandler } from '../utils/asyncHandler.js';

export const login = asyncHandler(async (req, res) => {
  // 1. On récupère l'email ET le password
  const { email, password } = req.body;

  if (!email || !password) {
    const error = new Error("Email and password are required");
    error.statusCode = 400;
    throw error;
  }

  // 2. On cherche par email (en incluant le mot de passe haché)
  const technician = await technicianRepository.findByEmailForLogin(email);
  
  // Pour des raisons de sécurité, on renvoie la même erreur générique 
  // si l'email n'existe pas ou si le mot de passe est faux
  if (!technician) {
    const error = new Error('Invalid credentials');
    error.statusCode = 401;
    throw error;
  }

  // 3. On compare le mot de passe fourni avec le hash en base de données
  const isMatch = await technician.matchPassword(password);
  if (!isMatch) {
    const error = new Error('Invalid credentials');
    error.statusCode = 401;
    throw error;
  }

  // 4. Génération du token
  const token = jwt.sign(
    { id: technician._id, email: technician.email },
    env.JWT_SECRET,
    { expiresIn: '1d' }
  );

  // 5. On retire le mot de passe de l'objet avant de l'envoyer au client
  technician.password = undefined;

  res.status(200).json({
    success: true,
    token,
    data: technician
  });
});

export const logout = asyncHandler(async (req, res) => {
  res.status(200).json({
    success: true,
    message: 'Logout successful.'
  });
});