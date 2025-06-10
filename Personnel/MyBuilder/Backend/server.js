const chalk = require("chalk");
const app = require("./src/app");

const PORT = process.env.PORT;
console.log(chalk.default.green(`🦖 Loading environment`));

// Start the server
app.listen(PORT, (err) => {
  if (err) {
    proccess.exit(1);
  }

  console.log(chalk.default.blue(`🥝 Server listening on port ${PORT}`));
});
