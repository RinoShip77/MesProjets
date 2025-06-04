const db = require("../core/database");

exports.getAll = function (callback) {
  db.query("SHOW TABLE STATUS WHERE COMMENT = 'productsTable'", callback);
};

exports.create = function (newCategory, callback) {
  db.query(`CREATE TABLE ${newCategory} (id int)`, callback);
};

exports.update = function (title, updatedCategory, callback) {
  db.query(`RENAME TABLE ${title} TO ${updatedCategory}`, callback);
};

exports.delete = function (title, callback) {
  db.query(`DROP TABLE ${title}`, callback);
};
