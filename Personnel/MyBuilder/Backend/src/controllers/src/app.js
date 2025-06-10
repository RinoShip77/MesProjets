const express = require("express");
const cors = require("cors");
const bodyParser = require("body-parser");
const categoriesRoutes = require("./routes/categories.route.js");
const productsRoutes = require("./routes/products.route.js");
const usersRoutes = require("./routes/users.route.js");
const ordersRoutes = require("./routes/orders.route.js");
const middleware = require("./middlewares/error.js");

const app = express();
app.use(cors({ origin: true, credentials: true }));

// Middleware
app.use(bodyParser.json());

// Routes
app.use("/categories", categoriesRoutes);
app.use("/products", productsRoutes);
app.use("/users", usersRoutes);
app.use("/orders", ordersRoutes);

// Error middleware
app.use(middleware);

module.exports = app;