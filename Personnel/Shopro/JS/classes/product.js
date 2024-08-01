import { Cart } from "./cart.js"
import * as helpers from "../helpers.js"

class Product {
  constructor(product) {
    this.id = product.id
    this.title = product.title
    this.price = product.price
    this.category = product.category
    this.description = product.description
    this.image = product.image
  }

  createCard(product) {
    let context = 'catalog'

    let image = helpers.getImage(product.image, product.title, context)
    let title = helpers.getTitle(product.title, context)
    let price = helpers.getPrice(product.price, context)
    let category = helpers.getCategory(product.category, context)

    let info = document.createElement('div')
    info.classList.add('d-flex', 'justify-content-between')
    info.append(price, category)

    let description = helpers.getDescription(product.description, true)

    let innerBody = document.createElement('div')
    innerBody.classList.add('card-body')
    innerBody.append(title, info, description)

    let body = document.createElement('a')
    body.classList.add('btn', 'text-reset', 'h-100')
    body.type = 'button'
    body.setAttribute('data-bs-toggle', 'modal')
    body.setAttribute('data-bs-target', '#productModal')
    body.onclick = function () {
      document.getElementById('productModalBody').innerHTML = ''
      document.getElementById('productModalBody').appendChild(product.createModal(product))
    }
    body.append(image, innerBody)

    let cartBtn = document.createElement('button')
    cartBtn.classList.add('btn', 'btn-primary')
    cartBtn.onclick = function () {
      let cart = new Cart()

      cart.addToCart(product)
    }
    cartBtn.innerHTML = 'Add to cart'

    let footer = document.createElement('div')
    footer.classList.add('card-footer', 'd-flex', 'justify-content-center', 'py-2')
    footer.append(cartBtn)

    let card = document.createElement('div')
    card.classList.add('card', 'bg-body-secondary', 'h-100')
    card.append(body, footer)

    let col = document.createElement('div')
    col.classList.add('col')
    col.appendChild(card)

    return col
  }

  createModal(product) {
    let context = 'modal'
    let image = helpers.getImage(product.image, product.title, context)
    let title = helpers.getTitle(product.title, context)
    let price = helpers.getPrice(product.price, context)
    let rating = helpers.getStars(Math.floor(Math.random() * 6))
    let category = helpers.getCategory(product.category, context)
    let description = helpers.getDescription(product.description, false)

    let body = document.createElement('div')
    body.classList.add('card-body', 'text-center')
    body.append(title, price, rating, category, description)
    //#endregion Set body

    //Set button
    let button = document.createElement('button')
    button.classList.add('btn', 'btn-primary', 'p-3', 'rounded-0', 'rounded-bottom')
    button.innerHTML = 'Add to cart'

    //Set card
    let card = document.createElement('div')
    card.classList.add('card')
    card.append(image, body, button)

    return card
  }
}

export { Product }