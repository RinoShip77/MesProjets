const Product = require("./Product");

class Processor extends Product {
  constructor(id, name, imageURL, productURL, price, manufacturer, quantityInStock, rating, series, microarchitecture, socket, coreCount, clock, integratedGraphics) {
    super(id, name, imageURL, productURL, price, manufacturer, quantityInStock, rating);
    this.series = series;
    this.microarchitecture = microarchitecture;
    this.socket = socket;
    this.coreCount = coreCount;
    this.clock = clock;
    this.integratedGraphics = integratedGraphics;
  }
}

module.exports = Processor;