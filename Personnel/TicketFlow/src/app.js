import express from 'express';
import helmet from 'helmet';
import cors from 'cors';
import rateLimit from 'express-rate-limit';
import dashboardRoutes from './routes/dashboard.routes.js';
import technicianRoutes from './routes/technician.routes.js';
import ticketRoutes from './routes/ticket.routes.js';
import authRoutes from './routes/auth.routes.js';
import { errorHandler } from './middlewares/error.middleware.js';
import { setupSwagger } from './config/swagger.js';

const app = express();

app.use(helmet());
app.use(express.json());

// On récupère la variable du .env, ou on met les valeurs par défaut si elle n'existe pas
const allowedOrigins = process.env.CLIENT_URL 
  ? process.env.CLIENT_URL.split(',') 
  : ['http://localhost:5173', 'http://localhost:4200'];

const corsOptions = {
  origin: allowedOrigins,
  credentials: true
};

app.use(cors(corsOptions));

// OBLIGATOIRE EN PRODUCTION : Fait confiance au proxy pour lire la vraie IP du client
app.set('trust proxy', 1);

// 1. Le limiteur Global (Généreux pour la navigation normale)
const globalLimiter = rateLimit({
  windowMs: 30 * 60 * 1000,
  max: 500, // Ajusté pour ne pas frustrer les utilisateurs
  standardHeaders: true,
  legacyHeaders: false,
  message: {
    success: false,
    message: 'Too many requests.'
  }
});

// 2. Le limiteur de Login (Extrêmement strict contre la force brute)
const loginLimiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 10, // Bloque après 10 tentatives échouées/réussies
  standardHeaders: true,
  legacyHeaders: false,
  message: {
    success: false,
    message: 'Too many connection attempts. Try again in 15 minutes.'
  }
});

// Application des limiteurs
app.use('/api/', globalLimiter);
app.use('/api/auth/login', loginLimiter); // Écrase le globalLimiter spécifiquement pour le login

// Enregistrement des routes (Aiguilleurs)
app.use('/api/auth', authRoutes);
app.use('/api/dashboard', dashboardRoutes);
app.use('/api/technicians', technicianRoutes);
app.use('/api/tickets', ticketRoutes);

// Enregistrement de la documentation interactive
setupSwagger(app);

// Gestionnaire global d'erreurs (toujours en dernier)
app.use(errorHandler);

export default app;