const Product = require("./Product");

class Motherboard extends Product {
  constructor(id, name, imageURL, productURL, price, manufacturer, quantity, rating, socket, formFactor, chipset, memoryMax, memoryType, memorySlots, onboardEthernet, wirelessNetworking) {
    super(id, name, imageURL, productURL, price, manufacturer, quantity, rating);
    this.socket = socket;
    this.formFactor = formFactor;
    this.chipset = chipset;
    this.memoryMax = memoryMax;
    this.memoryType = memoryType;
    this.memorySlots = memorySlots;
    this.onbpardEthernet = onboardEthernet;
    this.wirelessNetworking = wirelessNetworking;
  }
}

module.exports = Motherboard;