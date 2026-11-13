const express = require("express");
const orderController = require("../controllers/order.controller");

const router = express.Router();

// Routes
router.get("/", orderController.getAll);
router.get("/:id", orderController.getOne);
router.post("/checkout", orderController.checkout);
router.get("/checkout/success", orderController.checkoutSuccess);

module.exports = router;
