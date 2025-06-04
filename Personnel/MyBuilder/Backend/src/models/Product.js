class Product {
  constructor(id, name, imageURL, productURL, price, manufacturer, quantity, rating) {
    this.id = id;
    this.name = name;
    this.imageURL = imageURL;
    this.productURL = productURL;
    this.price = `${price.trim().slice(1)} $`;
    this.manufacturer = manufacturer;
    this.quantity = quantity;
    this.rating = rating;
  }
}

module.exports = Product;