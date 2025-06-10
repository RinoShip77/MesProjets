const Product = require("./Product");

class VideoCard extends Product {
  constructor(id, name, imageURL, productURL, price, manufacturer, quantityInStock, rating, chipset, memory, clock, frameSync) {
    super(id, name, imageURL, productURL, price, manufacturer, quantityInStock, rating);
    this.chipset = chipset;
    this.memory = memory;
    this.clock = clock;
    this.frameSync = frameSync;
  }
}

module.exports = VideoCard;