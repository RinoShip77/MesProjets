import * as helpers from "../helpers.js"

class Cart {
   constructor(cart = '') {
      this.id = cart.id
      this.userID = cart.userID
      this.date = cart.date
      this.products = cart.products
   }

   createCard(product, quantity = 1) {
      let context = 'cart'

      let badge = helpers.getCartBadge(quantity)
      let image = helpers.getImage(product.image, product.title, context)
      let title = helpers.getTitle(product.title, context)
      let price = helpers.getPrice(product.price, context)

      let body = document.createElement('div')
      body.classList.add('card-body')
      body.append(title, price)

      let removeBtn = document.createElement('button')
      removeBtn.classList.add('btn')
      removeBtn.onclick = async function () {
         let cart = new Cart()
         cart.removeFromCart(product.id)
      }
      removeBtn.innerHTML = 'Remove from cart'

      let footer = document.createElement('div')
      footer.classList.add('card-footer', 'bg-danger')
      footer.append(removeBtn)

      let card = document.createElement('div')
      card.classList.add('card', 'bg-body-secondary', 'text-center')
      card.style.height = '35rem'
      card.append(badge, image, body, footer)

      let col = document.createElement('div')
      col.classList.add('col', 'w-25')
      col.id = product.id
      col.appendChild(card)

      return col
   }

   addToCart(product, quantity = 1) {
      alert(`"${(product.title[0].toUpperCase() + product.title.slice(1)).trim()}" was added to your cart.`)
      
      if(document.getElementById('cartContainer').contains(document.getElementById(product.id))) {
         document.getElementById(product.id).querySelector('span').innerHTML = parseInt(document.getElementById('quantity').innerHTML) + 1
      } else {
         document.getElementById('cartContainer').appendChild(this.createCard(product, quantity))
      }
   }

   removeFromCart(productID) {
      document.getElementById(productID).remove()
   }
}

export { Cart }