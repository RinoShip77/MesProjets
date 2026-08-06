import Joi from 'joi';

const technicianBaseSchema = Joi.object({
  email: Joi.string().email().optional(), // Ajouté pour permettre la mise à jour de l'email
  name: Joi.string().max(255).required(),
  level: Joi.number().integer().min(1).max(3).optional(),
  password: Joi.string().min(8).optional() // Ajouté pour permettre la mise à jour du mot de passe
});

export const createTechnicianSchema = Joi.alternatives().try(
  technicianBaseSchema,
  Joi.array().items(technicianBaseSchema).min(1)
);

// On rend TOUT optionnel lors d'une mise à jour partielle
const technicianUpdateBaseSchema = Joi.object({
  name: Joi.string().max(255).optional(),
  email: Joi.string().email().optional(),
  password: Joi.string().min(8).optional(),
  level: Joi.number().integer().min(1).max(3).optional()
});

export const updateTechnicianSchema = Joi.alternatives().try(
  technicianUpdateBaseSchema,
  Joi.object({
    ids: Joi.array().items(Joi.string().hex().length(24)).min(1).required(),
    updateData: technicianUpdateBaseSchema.required()
  })
);

export const deleteBulkSchema = Joi.object({
  ids: Joi.array().items(Joi.string().hex().length(24)).min(1).required()
});