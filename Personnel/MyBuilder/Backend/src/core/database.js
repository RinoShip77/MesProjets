const mysql = require("mysql2");
const chalk = require("chalk");

require("dotenv").config();

console.log(chalk.default.green(`\n🧬 [MYSQL] - Establish new connection with url: ${process.env.DB_DATABASE} 🧬`));

const connection = mysql.createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_DATABASE,
});

connection.connect((err) => {
  if (err) {
    console.log(chalk.default.red(`🧬 [MYSQL] - Cannot connect to: ${process.env.DB_DATABASE}\n ${err} ... \n Exiting 🧬`));
    throw err;
  }

  console.log(chalk.default.green(`🧬 [MYSQL] - Connected to: ${process.env.DB_DATABASE} 🧬\n`));
});

module.exports = connection;
