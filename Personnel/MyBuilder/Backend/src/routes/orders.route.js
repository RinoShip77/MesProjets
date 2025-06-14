const express = require("express");
const orderController = require("../controllers/order.controller");

const router = express.Router();

// Routes
router.post("/checkout", orderController.checkout);
router.get("/checkout/success", orderController.checkoutSuccess);
router.get("/checkout/error", orderController.checkoutError);

module.exports = router;
