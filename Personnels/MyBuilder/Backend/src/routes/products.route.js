const express = require("express");
const productController = require("../controllers/product.controller");

const router = express.Router();

// Routes
router.get("/:table", productController.getAll);
router.get("/:table/:id", productController.getOne);
router.post("/add/:table", productController.create);
router.put("/modify/:table/:id", productController.update);
router.delete("/delete/:table/:id", productController.delete);

module.exports = router;
