const BASE_URL = "http://localhost:5000/";
const COLORS = ["primary", "secondary", "success", "danger", "warning", "info", "light", "dark"];
const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]')
const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl))

main();

function main() {
  fetchData();
  getProducts();

  // if (window.innerWidth < 1100) {
  //   document.getElementById("categoriesContainer").classList.add("row");

  //   for (let index = 0; index < document.getElementById("categoriesContainer").children.length; index++) {
  //     let newRow = document.createElement("div");
  //     newRow.classList.add("col");

  //     console.log(index)
  //     if(index === 1) {
  //       newRow.append(document.getElementById("categoriesContainer").children[index], document.getElementById("categoriesContainer").children[index + 1]);
  //       document.getElementById("categoriesContainer").appendChild(newRow);
  //     }
  //   }
  // } else {
  //   document.getElementById("categoriesContainer").classList.remove("row");
  // }
}

function getProducts(table = "cases") {
  document.getElementById("productsContainer").innerHTML = "";
  fetchData(`products/${table}`);
}

function createCategorySwitch(category) {
  let input = document.createElement("input");
  input.id = `${category.name}Switch`;
  input.classList.add("form-check-input", "me-3");
  input.name = "categorySwitch";
  input.type = "radio";
  input.role = "switch";
  input.onchange = function () {
    getProducts(category.name.replace(" ", "_").toLowerCase());
  }

  let label = document.createElement("label");
  label.innerHTML = `${category.name} ${categoryIcon(category.name)}`;
  label.classList.add("form-check-label");
  label.setAttribute("for", `${category.name}Switch`);
  label.setAttribute("data-bs-toggle", "tooltip");
  label.setAttribute("data-bs-title", `${category.count}`);
  label.setAttribute("data-bs-placement", "right");
  generateTooltip(label);

  let container = document.createElement("div");
  container.classList.add("form-check", "form-switch", "d-flex", "align-items-center", "my-3");
  container.append(input, label);

  document.getElementById("categoriesContainer").appendChild(container);
}

function createCategoryDropdown(category) {
  let link = document.createElement("a");
  link.type = "button";
  link.innerHTML = `${category.name} ${categoryIcon(category.name)}`;
  link.classList.add("dropdown-item");
  link.setAttribute("data-bs-toggle", "tooltip");
  link.setAttribute("data-bs-title", `${category.count}`);
  link.setAttribute("data-bs-placement", "right");
  generateTooltip(link);
  link.onclick = function () {
    getProducts(category.name.replace(" ", "_").toLowerCase());
  }

  let dropdownItem = document.createElement("li");
  dropdownItem.appendChild(link);

  document.getElementById("categoriesDropdown").appendChild(dropdownItem);
}

function createProduct(product) {
  let modalLink = document.createElement("a");
  modalLink.type = "button";
  modalLink.classList.add("card", "text-decoration-none", "h-100", "shadow");
  modalLink.setAttribute("data-bs-toggle", "modal");
  modalLink.setAttribute("data-bs-target", `#productModal${product.id}`);
  modalLink.append(createCardBody(product));
  createProductModal(product);

  let column = document.createElement("div");
  column.classList.add("col");
  column.appendChild(modalLink);

  document.getElementById("productsContainer").appendChild(column);
}

function createCardBody(product) {
  let imageTag = document.createElement("img");
  imageTag.src = product.imageURL;
  imageTag.onerror = function () { this.src = "https://static-00.iconduck.com/assets.00/no-image-icon-512x512-lfoanl0w.png" };
  imageTag.classList.add("card-img-top", "img-fluid", "img-thumbnail");
  imageTag.alt = `Image de ${product.name}`;

  let titleTag = document.createElement("h4");
  titleTag.innerHTML = product.name;
  titleTag.classList.add("card-title", "pt-2");

  let priceTag = document.createElement("p");
  priceTag.classList.add("text-body-secondary");
  priceTag.innerHTML = product.price;

  let body = document.createElement("div");
  body.classList.add("card-body", "d-flex", "flex-column", "justify-content-between", "bg-body-secondary");
  body.append(imageTag, titleTag, priceTag, createCardFooter(product));

  return body;
}

function createCardFooter(product) {
  let footer = document.createElement("button");
  footer.classList.add("btn", "btn-success", "w-auto")
  footer.type = "button";
  footer.innerHTML = "Add To Cart";
  footer.onclick = function () {
    addToCart(product);
  }

  return footer;
}

function createQuantityInput(quantity) {
  let decreaseQuantity = document.createElement("a");
  decreaseQuantity.innerHTML = "<i class='bi bi-dash-square-fill'></i>";
  decreaseQuantity.type = "button";
  decreaseQuantity.classList.add("btn", "btn-sm");

  let input = document.createElement("input");
  input.type = "number";
  input.classList.add("form-control");
  input.style.width = "3em";
  input.placeholder = quantity;
  input.min = 0;

  let increaseQuantity = document.createElement("a");
  increaseQuantity.innerHTML = "<i class='bi bi-plus-square-fill'></i>";
  increaseQuantity.type = "button";
  increaseQuantity.classList.add("btn", "btn-sm");

  let inputGroup = document.createElement("div");
  inputGroup.classList.add("d-flex", "align-items-center");
  inputGroup.append(decreaseQuantity, input, increaseQuantity);

  return inputGroup;
}

function createProductModal(product) {
  let node_1 = document.createElement("DIV");
  node_1.classList.add("modal", "fade");
  node_1.setAttribute("id", `productModal${product.id}`);
  node_1.setAttribute("tabindex", "-1");
  node_1.setAttribute("aria-labelledby", product.name);

  let node_2 = document.createElement("DIV");
  node_2.classList.add("modal-dialog");
  node_1.appendChild(node_2);

  let node_3 = document.createElement("DIV");
  node_3.classList.add("modal-content");
  node_2.appendChild(node_3);

  let node_4 = document.createElement("DIV");
  node_4.classList.add("modal-header");
  node_3.appendChild(node_4);

  let node_5 = document.createElement("H1");
  node_5.innerHTML = product.name;
  node_5.classList.add("modal-title", "fs-5");
  node_5.setAttribute("id", "exampleModalLabel");
  node_4.appendChild(node_5);

  let node_7 = document.createElement("BUTTON");
  node_7.setAttribute("type", "button");
  node_7.classList.add("btn-close");
  node_7.setAttribute("data-bs-dismiss", "modal");
  node_7.setAttribute("aria-label", "Close");
  node_4.appendChild(node_7);

  let node_8 = document.createElement("DIV");
  node_8.classList.add("modal-body");
  node_3.appendChild(node_8);

  let node_9 = document.createElement("DIV");
  node_9.classList.add("modal-footer");
  node_3.appendChild(node_9);

  let node_10 = document.createElement("BUTTON");
  node_10.setAttribute("type", "button");
  node_10.classList.add("btn", "btn-secondary");
  node_10.setAttribute("data-bs-dismiss", "modal");
  node_9.appendChild(node_10);

  let node_11 = document.createTextNode((new String("Close")));
  node_10.appendChild(node_11);

  let node_12 = document.createElement("BUTTON");
  node_12.setAttribute("type", "button");
  node_12.classList.add("btn", "btn-primary");
  node_9.appendChild(node_12);

  let node_13 = document.createTextNode((new String("Save changes")));
  node_12.appendChild(node_13);

  document.body.appendChild(node_1);
}

function genratePlaceholder(number) {
  for (let index = 0; index < number; index++) {

    var node_1 = document.createElement('DIV');
    node_1.setAttribute('class', 'card');
    node_1.setAttribute('aria-hidden', 'true');

    var node_2 = document.createElement('IMG');
    node_2.setAttribute('src', 'https://static-00.iconduck.com/assets.00/no-image-icon-512x512-lfoanl0w.png');
    node_2.classList.add('card-img-top', 'w-75', 'mx-auto', 'pt-3');
    node_2.setAttribute('alt', 'Image');
    node_1.appendChild(node_2);

    var node_3 = document.createElement('DIV');
    node_3.setAttribute('class', 'card-body');
    node_1.appendChild(node_3);

    var node_4 = document.createElement('H5');
    node_4.setAttribute('class', 'card-title placeholder-glow');
    node_3.appendChild(node_4);

    var node_5 = document.createElement('SPAN');
    node_5.setAttribute('class', 'placeholder col-6');
    node_4.appendChild(node_5);

    var node_6 = document.createElement('P');
    node_6.setAttribute('class', 'card-text placeholder-glow');
    node_3.appendChild(node_6);

    var node_7 = document.createElement('SPAN');
    node_7.setAttribute('class', 'placeholder col-7');
    node_6.appendChild(node_7);

    var node_8 = document.createElement('SPAN');
    node_8.setAttribute('class', 'placeholder col-4');
    node_6.appendChild(node_8);

    var node_9 = document.createElement('SPAN');
    node_9.setAttribute('class', 'placeholder col-4');
    node_6.appendChild(node_9);

    var node_10 = document.createElement('SPAN');
    node_10.setAttribute('class', 'placeholder col-6');
    node_6.appendChild(node_10);

    var node_11 = document.createElement('SPAN');
    node_11.setAttribute('class', 'placeholder col-8');
    node_6.appendChild(node_11);

    var node_12 = document.createElement('A');
    node_12.setAttribute('class', 'btn btn-primary disabled placeholder col-6');
    node_12.setAttribute('aria-disabled', 'true');
    node_3.appendChild(node_12);

    document.getElementById("productsContainer").appendChild(node_1);
  }
}

function addToCart(product, quantity = 1) {
  // let cart = localStorage.getItem("cart");
  // cart = cart ? JSON.parse(cart) : [];
  
  // const existingProductIndex = cart.findIndex((item) => item.id === product.id);
  
  // if (existingProductIndex !== -1) {
  //   cart[existingProductIndex].quantity += quantity;
  // } else {
  //   cart.push(product);
  // }
  
  // console.log(quantity);
  // localStorage.setItem("cart", JSON.stringify(cart));
}

function categoryIcon(category) {
  let icon;

  switch (category) {
    case "Coolers":
      icon = "<i class='bi bi-fan'></i>";
      break;
    case "Motherboards":
      icon = "<i class='bi bi-motherboard-fill'></i>";
      break;
    case "Power supplies":
      icon = "<i class='bi bi-battery-charging'></i>";
      break;
    case "Processors":
      icon = "<i class='bi bi-cpu-fill'></i>";
      break;
    case "Ram brackets":
      icon = "<i class='bi bi-nvme-fill'></i>";
      break;
    case "Storage drives":
      icon = "<i class='bi bi-device-ssd-fill'></i>";
      break;
    case "Video cards":
      icon = "<i class='bi bi-pci-card'></i>";
      break;

    default:
      icon = "<i class='bi bi-pc'></i>";
      break;
  }

  return icon;
}

function generateTooltip(element) {
  return new bootstrap.Tooltip(element, {
    container: document.body
  })
}

function fetchData(path = "categories") {
  fetch(BASE_URL + path)
    .then(response => {
      if (response.ok) {
        return response.json();
      } else {
        throw new Error("Network response was not ok");
      }
    })
    .then(data => {
      data.forEach(element => {
        if (path.includes("/")) {
          switch (path.substring(0, path.indexOf("/"))) {
            case "products":
              (element) ? createProduct(element) : genratePlaceholder(25);
              break;
            case "users":
              // createUser(element);
              break;
          }
        } else {
          createCategoryDropdown(element);
          createCategorySwitch(element);
        }
      });
    })
    .catch(error => console.error("There was a problem with the fetch operation:", error));
}
