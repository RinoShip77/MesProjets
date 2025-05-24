const Product = require("./Product");

class VideoCard extends Product {
  constructor(name, imageURL, productURL, price, manufacturer, chipset, memory, clock, frameSync) {
    super(name, imageURL, productURL, price, manufacturer);
    this.chipset = chipset;
    this.memory = memory;
    this.clock = clock;
    this.frameSync = frameSync;
  }
}

module.exports = VideoCard;