const db = require("../core/database");

exports.getAll = function (callback) {
  db.query(`SELECT * FROM users`, callback);
};

exports.login = function (user, callback) {
  if(user.email) {
    db.query(`SELECT * FROM users WHERE email = '${user.email}' AND password = '${user.password}'`, callback);
  } else {
    db.query(`SELECT * FROM users WHERE username = '${user.username}' AND password = '${user.password}'`, callback);
  }
};

exports.create = function (newUser, callback) {
  db.query(`INSERT INTO users SET ?`, [newUser], callback);
};

exports.update = function (id, updatedUser, callback) {
  db.query(`UPDATE users SET ? WHERE id = ${id}`, [updatedUser], callback);
};

exports.delete = function (id, callback) {
  db.query(`DELETE FROM users WHERE id = ${id}`, callback);
};
