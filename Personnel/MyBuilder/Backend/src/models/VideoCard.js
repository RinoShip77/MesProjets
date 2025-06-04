const Product = require("./Product");

class VideoCard extends Product {
  constructor(id, name, imageURL, productURL, price, manufacturer, quantity, rating, chipset, memory, clock, frameSync) {
    super(id, name, imageURL, productURL, price, manufacturer, quantity, rating);
    this.chipset = chipset;
    this.memory = memory;
    this.clock = clock;
    this.frameSync = frameSync;
  }
}

module.exports = VideoCard;