const Product = require("./Product");

class Case extends Product {
  constructor(id, name, imageURL, productURL, price, manufacturer, quantity, rating, type, powerSupply, sidePanel, frontPanelUSB, motherboardFormFactor, maximumVideoCardLength, dimensions) {
    super(id, name, imageURL, productURL, price, manufacturer, quantity, rating);
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