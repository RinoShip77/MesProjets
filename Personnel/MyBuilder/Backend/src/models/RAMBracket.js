const Product = require("./Product");

class RAMBracket extends Product {
  constructor(id, name, imageURL, productURL, price, manufacturer, quantityInStock, rating, speed, module, voltage, frameSync) {
    super(id, name, imageURL, productURL, price, manufacturer, quantityInStock, rating);
    this.speed = speed;
    this.module = module;
    this.voltage = voltage;
  }
}

module.exports = RAMBracket;