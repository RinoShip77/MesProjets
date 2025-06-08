const express = require("express");
const userController = require("../controllers/user.controller");

const router = express.Router();

// Routes
router.get("/", userController.getAll);
router.post("/login", userController.login);
router.post("/add", userController.create);
router.put("/modify/:id", userController.update);
router.delete("/delete/:id", userController.delete);

module.exports = router;
