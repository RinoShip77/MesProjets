import 'dotenv/config';
import { jest } from '@jest/globals';
import request from 'supertest';
import mongoose from 'mongoose';
import app from '../../src/app.js';
import database from '../../src/libs/database.js';

describe('Tickets API Routes (Integration)', () => {
  
  beforeAll(async () => {
    await database();
  });

  afterAll(async () => {
    await mongoose.connection.close();
  });

  test('GET /api/tickets should respond with success (200) and an array', async () => {
    const response = await request(app).get('/api/tickets');
    
    expect(response.status).toBe(200);
    expect(Array.isArray(response.body.tickets)).toBe(true);
  });

  test('POST /api/tickets without token should reject access (401)', async () => {
    const response = await request(app)
      .post('/api/tickets')
      .send({});

    expect(response.status).toBe(401);
  });
});