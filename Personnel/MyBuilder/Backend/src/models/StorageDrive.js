const Product = require("./Product");

class StorageDrive extends Product {
  constructor(name, imageURL, productURL, price, manufacturer, capacity, type) {
    super(name, imageURL, productURL, price, manufacturer);
    this.capacity = capacity;
    this.type = type;
  }
}

module.exports = StorageDrive;