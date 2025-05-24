class Product {
  constructor(name, imageURL, productURL, price, manufacturer) {
    this.name = name;
    this.imageURL = imageURL;
    this.productURL = productURL;
    this.price = `${price.trim().slice(1)} $`;
    this.manufacturer = manufacturer;
  }
}

module.exports = Product;