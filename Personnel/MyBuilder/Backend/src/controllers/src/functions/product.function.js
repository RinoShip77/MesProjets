const db = require("../core/database");

exports.geAllCategories = function (callback) {
  db.query(`SHOW TABLES`, callback);
};

exports.getAll = function (table, callback) {
  db.query(`SELECT * FROM ${table}`, callback);
};

exports.getOne = function (table, id, callback) {
  db.query(`SELECT * FROM ${table} WHERE id = ${id}`, callback);
};

exports.create = function (table, newProduct, callback) {
  db.query(`INSERT INTO ${table} SET ?`, [newProduct], callback);
};

exports.update = function (table, id, updatedProduct, callback) {
  db.query(`UPDATE ${table} SET ? WHERE id = ${id}`, [updatedProduct], callback);
};

exports.delete = function (table, id, callback) {
  db.query(`DELETE FROM ${table} WHERE id = ${id}`, callback);
};
