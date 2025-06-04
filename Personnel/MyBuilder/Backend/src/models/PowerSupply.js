const Product = require("./Product");

class PowerSupply extends Product {
  constructor(id, name, imageURL, productURL, price, manufacturer, quantity, rating, type, wattage, length) {
    super(id, name, imageURL, productURL, price, manufacturer, quantity, rating);
    this.type = type;
    this.wattage = wattage;
    this.length = length;
  }
}

module.exports = PowerSupply;