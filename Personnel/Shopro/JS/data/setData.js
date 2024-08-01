import * as data from "./getData.js"
import * as component from "../component.js"
import { Product } from "../classes/product.js"
import { Category } from "../classes/category.js"
import { Cart } from "../classes/cart.js"

async function setProducts(category = '') {
   let products = await data.getProducts(category)

   document.getElementById('productsContainer').innerHTML = ''
   products.forEach(product => {
      let myProduct = new Product(product)
      
      document.getElementById('productsContainer').appendChild(component.createCatalog(myProduct))
   })
}

async function setCategories() {
   let categories = await data.getCategories()
   
   categories.forEach(category => {
      for (let index = 0; index < document.getElementsByClassName('categoriesContainer').length; index++) {
         let myCategory = new Category(category)
         
         document.getElementsByClassName('categoriesContainer')[index].appendChild(component.createCategory(myCategory));
      }
   })
}

async function setCart(userID = 1) {
   if(localStorage.getItem('userID')) {
      userID = localStorage.getItem('userID')
   }
   
   let cart = await data.getCart(userID)
   
   cart[0].products.forEach(async product => {
      let myCart = new Cart(cart[0])

      document.getElementById('cartContainer').appendChild(component.createCart(myCart, await data.getProduct(product.productId)));
   })
}

export { setProducts, setCategories, setCart }