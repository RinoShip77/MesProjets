const Product = require("./Product");

class Case extends Product {
  constructor(name, imageURL, productURL, price, manufacturer, type, powerSupply, sidePanel, frontPanelUSB, motherboardFormFactor, maximumVideoCardLength, dimensions) {
    super(name, imageURL, productURL, price, manufacturer);
    this.type = type;
    this.powerSupply = powerSupply;
    this.sidePanel = sidePanel;
    this.frontPanelUSB = frontPanelUSB;
    this.motherboardFormFactor = motherboardFormFactor;
    this.maximumVideoCardLength = maximumVideoCardLength;
    this.dimensions = dimensions;
  }
}

module.exports = Case;