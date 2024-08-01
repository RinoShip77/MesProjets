function getStars(number) {
   let rating = document.createElement('div')
   rating.classList.add('py-3', 'border-top')

   if (number > 0) {
      for (let index = 0; index < number; index++) {
         let icon = document.createElement('i')
         icon.classList.add('fas', 'fa-star', 'text-warning')

         rating.appendChild(icon)
      }

      for (let index = 0; index < (5 - number); index++) {
         let icon = document.createElement('i')
         icon.classList.add('far', 'fa-star', 'text-warning')

         rating.appendChild(icon)
      }
   } else {
      let icon = document.createElement('i')
      icon.classList.add('fas', 'fa-comment-slash', 'text-body-secondary', 'fs-2')

      rating.appendChild(icon)
   }

   return rating
}

function getCartBadge(quantity) {
   let badge = document.createElement('span')
   badge.classList.add('position-absolute', 'top-0', 'start-100', 'translate-middle', 'badge', 'rounded-pill', 'bg-danger')
   badge.id = 'quantity'
   badge.ariaLabel = quantity
   badge.innerHTML = quantity

   return badge
}

function getImage(src, title, context) {
   let image = document.createElement('img')
   image.classList.add('card-img-top')
   image.src = src
   image.alt = title

   if (context !== 'modal') {
      image.style.height = '250px'
      image.style.aspectRatio = '1/1'
   } else {
      image.classList.add('mx-auto', 'w-50')
   }

   return image
}

function getTitle(text, context) {
   let title = document.createElement('p')
   title.classList.add('card-title')

   switch (context) {
      case 'catalog':
         title.classList.add('h4')
         title.innerHTML = text

      case 'modal':
         title.classList.add('fs-5')
         title.innerHTML = text

      case 'cart':
         title.classList.add('h3')
         title.innerHTML = text
   }

   return title
}

function getPrice(amount, context) {
   let price = document.createElement('p')
   price.innerHTML = `$${amount}`

   if (context !== 'modal') {
      price.classList.add('card-text')
   } else {
      price.classList.add('h1')
   }

   return price
}

function getCategory(text, context) {
   let category = document.createElement('p')
   category.classList.add('text-capitalize')
   category.innerHTML = text

   if (context !== 'modal') {
      category.classList.add('card-text')
   } else {
      category.classList.add('h5')
   }

   return category
}

function getDescription(text, isShort) {
   let description = document.createElement('p')
   
   if (isShort) {
      description.classList.add('card-text')
      description.innerHTML = `${text.substr(0, text.indexOf(' ', 75))} ...`
   } else {
      description.innerHTML = text
   }

   return description
}

export { getStars, getCartBadge, getImage, getTitle, getPrice, getCategory, getDescription }