const categoryFunctions = require("../functions/category.function");
const Category = require("../models/Category");

exports.getAll = function (req, res) {
  categoryFunctions.getAll((err, categories) => {
    if (err) throw err;
    let elements = [];

    categories.forEach(category => {
      elements.push(new Category(category.Name.replace(/_/g, " ").replace(/^./, category.Name.replace(/_/g, " ")[0].toUpperCase()), category.Rows));
    });

    res.json(elements);
  });
};

exports.create = function (req, res) {
  const newCategory = req.body.title;

  categoryFunctions.create(newCategory, (err, result) => {
    if (err) throw err;
    res.json({
      message: `The category ${req.body.title} was created successfully.`,
    });
  });
};

exports.update = function (req, res) {
  const updatedCategory = req.body.title;

  categoryFunctions.update(req.params.title, updatedCategory, (err, result) => {
    if (err) throw err;
    res.json({
      message: `The category ${req.params.title} was rename to ${req.body.title}.`,
    });
  }
  );
};

exports.delete = function (req, res) {
  categoryFunctions.delete(req.params.title, (err, result) => {
    if (err) throw err;
    res.json({
      message: `The category ${req.params.title} and all of his products where deleted successfully.`,
    });
  });
};
