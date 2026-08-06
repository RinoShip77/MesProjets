import jwt from 'jsonwebtoken'; // 1. L'import crucial

//#region Exercice 36 : La Sécurité (Authentification JWT)
export const authenticateToken = (req, res, next) => {
  const authHeader = req.headers.authorization;

  // 2. On inverse la logique : on bloque IMMÉDIATEMENT si c'est invalide (Early Return)
  if (!authHeader || !authHeader.startsWith('Bearer ')) {
    return res.status(401).json({ message: 'Access Token Required' });
  }

  // Si on passe la première condition, on sait que le Bearer est là
  const token = authHeader.split(' ')[1];

  if (!token) {
    return res.status(401).json({ message: 'Access Token Required' });
  }

  jwt.verify(token, process.env.JWT_SECRET, (error, payload) => {
    if (error) {
      return res.status(401).json({ message: 'Unauthorized (Invalid or expired)' });
    }
    
    // On attache les infos de l'utilisateur à la requête pour les prochaines étapes
    req.technician = payload;
    next();
  });
};
//#endregion