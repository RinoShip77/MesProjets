const express = require("express");
const categoryController = require("../controllers/category.controller");

const router = express.Router();

// Routes
router.get("/", categoryController.getAll);
router.post("/add", categoryController.create);
router.put("/modify/:title", categoryController.update);
router.delete("/delete/:title", categoryController.delete);

module.exports = router;
