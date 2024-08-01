import { setProducts } from "../data/setData.js"
import * as helpers from "../helpers.js"

class Category {
   constructor(category) {
      this.id = category
      this.name = category
   }

   createComponent(name) {
      let input = document.createElement('input')
      input.classList.add('form-check-input')
      input.type = 'radio'
      input.name = 'filterRadioBtn'
      input.id = name

      let label = document.createElement('label')
      label.classList.add('form-check-label', 'text-capitalize', 'text-nowrap')
      label.setAttribute('for', name)
      label.innerHTML = name

      let form = document.createElement('div')
      form.classList.add('form-check', 'ps-4')
      form.onclick = function () {
         for (let index = 0; index < document.getElementsByClassName('form-check-input').length; index++) {
            if (document.getElementsByClassName('form-check-input')[index].checked) {
               setProducts(`/category/${name}`)
            };
         }
      }
      form.append(input, label)

      return form
   }
}

export { Category }