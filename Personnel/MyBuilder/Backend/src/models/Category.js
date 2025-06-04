class Category {
  static id = 0;

  constructor(name, count) {
    this.id = ++Category.id;
    this.name = name;
    this.count = count;
  }
}

module.exports = Category;