const Product = require("./Product");

class Motherboard extends Product {
  constructor(name, imageURL, productURL, price, manufacturer, socket, formFactor, chipset, memoryMax, memoryType, memorySlots, onboardEthernet, wirelessNetworking) {
    super(name, imageURL, productURL, price, manufacturer);
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