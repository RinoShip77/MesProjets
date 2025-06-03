const Product = require("./Product");

class RAMBracket extends Product {
  constructor(id, name, imageURL, productURL, price, manufacturer, speed, module, voltage, frameSync) {
    super(id, name, imageURL, productURL, price, manufacturer);
    this.speed = speed;
    this.module = module;
    this.voltage = voltage;
  }
}

module.exports = RAMBracket;