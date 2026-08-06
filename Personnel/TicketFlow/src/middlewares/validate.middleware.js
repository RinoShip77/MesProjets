//#region Exercice 35 : Le Bouclier de Validation (Middleware)
export const validateRequest = (schema) => {
  return (req, res, next) => {
    const { error } = schema.validate(req.body, { abortEarly: false });

    if (error) {
      return res.status(400).json({ message: 'Validation failed', details: error.details });
    }
    next();
  };
};
//#endregion