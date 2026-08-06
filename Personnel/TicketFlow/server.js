import 'dotenv/config';
import { env } from './src/config/env.config.js';
import app from './src/app.js';
import database from './src/libs/database.js';
import seedDatabase from './src/libs/seed.js';

async function start() {
  await database();

  if (process.env.NODE_ENV !== 'production') {
    await seedDatabase();
  }

  app.listen(env.PORT, () => {
    console.log(`[Express] Server listening on port ${env.PORT}`);
    console.log('-----------------------------------------------\n');
  });
}

start();