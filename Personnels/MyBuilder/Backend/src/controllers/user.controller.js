const userFunctions = require("../functions/user.function");
const User = require("../models/User");

exports.getAll = function (req, res) {
  userFunctions.getAll((err, users) => {
    if (err) throw err;
    res.json(users);
  });
};

exports.login = async function (req, res) {
  const tempUser = new User(req.body.email, req.body.password);
  // await tempUser.hashPassword();
  
  userFunctions.login(tempUser, async (err, user) => {
    if (err) throw err;
    
    if (user.length === 0) {
      res.json({ message: `Bad credentials.` });
    } else {
      res.json({user: user[0], message: `Connected as '${req.body.email}'.` });
    }
  });
};

exports.create = async function (req, res) {
  const newUser = new User(req.body.email, req.body.password, req.body.firstName, req.body.lastName);
  // await newUser.hashPassword();

  userFunctions.create(newUser, (err, result) => {
    if (err) throw err;
    res.json({ message: `The user ${req.body.firstName} was created successfully.` });
  });
};

exports.update = async function (req, res) {
  const updatedUser = new User(req.body.email, req.body.password, req.body.firstName, req.body.lastName);
  // await updatedUser.hashPassword();

  userFunctions.update(req.params.id, updatedUser, (err, user) => {
    if (err) throw err;
    res.json({ message: `The user ${req.params.id} was updated successfully.` });
  });
};

exports.delete = function (req, res) {
  userFunctions.delete(req.params.id, (err, result) => {
    if (err) throw err;
    res.json({ message: `The user ${req.params.id} was deleted successfully.` });
  });
};
