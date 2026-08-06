import Joi from 'joi';

// 1. La fondation stricte (Objet unique)
const ticketBaseSchema = Joi.object({
  title: Joi.string().max(100).required(),
  description: Joi.string().required(),
  priority: Joi.number().integer().min(1).max(5).optional(),
  originDepartment: Joi.string().optional(),
  status: Joi.string().valid('Open', 'In progress', 'Resolved', 'Closed').optional(),
  assignedTo: Joi.string().hex().length(24).optional()
});

// 2. Le schéma de CRÉATION (Smart Endpoint)
// Accepte un objet unique OU un tableau d'objets
export const createTicketSchema = Joi.alternatives().try(
  ticketBaseSchema,
  Joi.array().items(ticketBaseSchema).min(1)
);

// 3. Le schéma de MISE À JOUR (PATCH Dynamique)
// Rend tous les champs obligatoires de la base optionnels pour permettre des modifs partielles
const ticketUpdateBaseSchema = ticketBaseSchema.fork(
  ['title', 'description'], 
  (schema) => schema.optional()
);

// Accepte une modif unique (ex: { status: "Resolved" }) 
// OU une modif en lot (ex: { ids: ["..."], updateData: { status: "Resolved" } })
export const updateTicketSchema = Joi.alternatives().try(
  ticketUpdateBaseSchema,
  Joi.object({
    ids: Joi.array().items(Joi.string().hex().length(24)).min(1).required(),
    updateData: ticketUpdateBaseSchema.required()
  })
);

// 4. Le schéma de SUPPRESSION EN LOT
export const deleteBulkSchema = Joi.object({
  ids: Joi.array().items(Joi.string().hex().length(24)).min(1).required()
});

// 5. Le schéma pour ajouter une NOTE
export const addNoteSchema = Joi.object({
  text: Joi.string().required(),
  technician: Joi.string().hex().length(24).optional()
});