import dotenv from 'dotenv';
import Joi from 'joi';

dotenv.config();

const envSchema = Joi.object({
  PORT: Joi.number().default(3000),
  MONGODB_URI: Joi.string().required(),
  JWT_SECRET: Joi.string().required()
}).unknown();

const { error, value } = envSchema.validate(process.env);

if (error) {
  throw new Error(`Invalid environment configuration : ${error.message}`);
}

export const env = value;