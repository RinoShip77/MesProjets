const Product = require("./Product");

class PowerSupply extends Product {
  constructor(name, imageURL, productURL, price, manufacturer, type, rating, wattage, length) {
    super(name, imageURL, productURL, price, manufacturer);
    this.type = type;
    this.rating = rating;
    this.wattage = wattage;
    this.length = length;
  }
}

module.exports = PowerSupply;