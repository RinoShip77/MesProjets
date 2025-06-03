const Product = require("./Product");

class Cooler extends Product {
  constructor(id, name, imageURL, productURL, price, manufacturer, fanRPM, noiseLvl, height, waterCooled, fanless) {
    super(id, name, imageURL, productURL, price, manufacturer);
    this.fanRPM = fanRPM;
    this.noiseLvl = noiseLvl;
    this.height = height;
    this.waterCooled = waterCooled;
    this.fanless = fanless;
  }
}

module.exports = Cooler;