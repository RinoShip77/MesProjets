const express = require("express");
const orderController = require("../controllers/order.controller");

const router = express.Router();

// Routes
router.post("/add", orderController.create);
router.post("/checkout", orderController.checkout);

module.exports = router;
