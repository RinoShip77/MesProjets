const bcrypt = require('bcrypt');

class User {
  constructor(email, password, fistName = '', lastName = '', role = 'user') {
    this.email = email;
    this.password = password;
    this.firstName = fistName;
    this.lastName = lastName;
  };

  async hashPassword() {
    try {
      this.password = await bcrypt.hash(this.password, 10);
    } catch (error) {
      console.error("Error hashing password:", error);
      throw error;
    }
  }

  async comparePassword(password) {
    return await bcrypt.compare(password, this.password, (err, res) => {
            // res == true or res == false
            console.log(res)
            // return res; 
        })
    // return await bcrypt.compare(password, this.password);
  }
}

module.exports = User;