const bcrypt = require('bcrypt');

class User {
  constructor(email = '', username = '', password = '', fistName = '', lastName = '', role = '') {
    this.email = email;
    this.username = username;
    this.password = password;
    this.firstName = fistName;
    this.lastName = lastName;
    this.role = role;
  };

  async hashPassword() {
    try {
      this.password = await bcrypt.hash(this.password, (Math.floor(Math.random() * 12) + 10));
    } catch (error) {
      console.error("Error hashing password:", error);
      throw error;
    }
  }

  async comparePassword(password) {
    return await bcrypt.compare(password, this.password);
  }
}

module.exports = User;