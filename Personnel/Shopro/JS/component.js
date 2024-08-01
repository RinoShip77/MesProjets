function createCatalog(product) {
   return product.createCard(product)
}

function createCategory(category) {
   return category.createComponent(category.name)
}

function createCart(cart, product) {
   return cart.createCard(product)
}

export { createCatalog, createCategory, createCart }