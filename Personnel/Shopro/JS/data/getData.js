async function getProducts(filter = '') {
   let response = await (await fetch(`https://fakestoreapi.com/products${filter}`)).json()

   return response
}

async function getProduct(filter = '') {
   let response = await (await fetch(`https://fakestoreapi.com/products/${filter}`)).json()

   return response
}

async function getCategories() {
   let response = await (await fetch('https://fakestoreapi.com/products/categories')).json()

   return response
}

async function getCart() {
   let response = await (await fetch(`https://fakestoreapi.com/carts?limit=1`)).json()

   return response
}

export { getProducts, getProduct, getCategories, getCart }