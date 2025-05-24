const Product = require("./Product");

class Processor extends Product {
  constructor(name, imageURL, productURL, price, manufacturer, series, microarchitecture, socket, coreCount, clock, integratedGraphics) {
    super(name, imageURL, productURL, price, manufacturer);
    this.series = series;
    this.microarchitecture = microarchitecture;
    this.socket = socket;
    this.coreCount = coreCount;
    this.clock = clock;
    this.integratedGraphics = integratedGraphics;
  }
}

module.exports = Processor;