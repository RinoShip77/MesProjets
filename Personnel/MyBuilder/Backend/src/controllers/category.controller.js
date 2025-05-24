const categoryFunctions = require("../functions/category.function");

exports.getAll = function (req, res) {
  categoryFunctions.getAll((err, categories) => {
    if (err) throw err;
    res.json(categories);
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
