class Product {
  constructor(id, name, imageURL, productURL, price, manufacturer) {
    this.id = id;
    this.name = name;
    this.imageURL = imageURL;
    this.productURL = productURL;
    this.price = `${price.trim().slice(1)} $`;
    this.manufacturer = manufacturer;
  }
}

module.exports = Product;