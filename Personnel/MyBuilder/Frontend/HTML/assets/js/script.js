const BASE_URL = "http://localhost:5000/";
const COLORS = ["primary", "secondary", "success", "danger", "warning", "info", "light", "dark"];

main();

function main() {
  fetchData("categories");
  getProducts();
}

function getProducts(table = "cases") {
  document.getElementById("productsContainer").innerHTML = "";
  fetchData(`products/${table}`);
}

function createCategorySwitch(category) {
  let input = document.createElement("input");
  input.id = `${category.title}Switch`;
  input.classList.add("form-check-input", "me-3", "fs-5");
  input.name = "categorySwitch";
  input.type = "radio";
  input.role = "switch";
  input.onchange = function () {
    getProducts(category.title);
  }

  let label = document.createElement("label");
  label.innerHTML = `${category.title.replace("_", " ")} ${categoryIcon(category.title.replace("_", " "))}`;
  label.classList.add("form-check-label", "text-capitalize", "fs-4");
  label.setAttribute("for", `${category.title}Switch`);

  let container = document.createElement("div");
  container.classList.add("form-check", "form-switch", "d-flex", "align-items-center", "my-3");
  container.append(input, label);

  document.getElementById("categoriesContainer").appendChild(container);
}

function createCategoryDropdown(category) {
  let link = document.createElement("a");
  link.innerHTML = `${category.title.replace("_", " ")} ${categoryIcon(category.title.replace("_", " "))}`;
  link.classList.add("dropdown-item", "text-capitalize");
  link.onclick = function () {
    getProducts(category.title);
  }

  let dropdownItem = document.createElement("li");
  dropdownItem.appendChild(link);

  document.getElementById("categoriesDropdown").appendChild(dropdownItem);
}

function createProduct(product) {
  let number = Math.floor(Math.random() * 100);

  let column = document.createElement("div");
  column.classList.add("col");

  let card = document.createElement("div");
  card.classList.add("card", "h-100", "shadow-sm");
  column.appendChild(card);

  let modalLink = document.createElement("button");
  modalLink.type = "button";
  modalLink.setAttribute("data-bs-toggle", "modal");
  modalLink.setAttribute("data-bs-toggle", `#productModal`);
  column.onclick = function () {
    createProductModal(product);
  }
  modalLink.appendChild(column);  

  card.append(createBody(element.imageURL, element.name, element.price, element.quantity));
  card.append(createCardBody(product.imageURL, product.name, product.price, 2, number));
  document.getElementById("productsContainer").appendChild(column);
}

function createCardBody(image, title, price, quantity, number) {
  let imageTag = document.createElement("img");
  imageTag.src = image;
  imageTag.classList.add("card-img-top", "img-fluid", "img-thumbnail");
  imageTag.alt = `Image de ${title}`;

  let titleTag = document.createElement("h4");
  titleTag.innerHTML = title;
  titleTag.classList.add("card-title", "pt-2");

  let priceTag = document.createElement("p");
  priceTag.innerHTML = price;
  priceTag.classList.add("text-body-secondary");



  var node_1 = document.createElement('BUTTON');
  node_1.setAttribute('type', 'button');
  node_1.setAttribute('class', 'btn btn-primary');
  node_1.setAttribute('data-bs-toggle', 'modal');
  node_1.setAttribute('data-bs-target', `productModal${number}`);
  node_1.onclick = function () {
    createProductModal(image, number);
  }

  var node_2 = document.createTextNode((new String("Launch demo modal")));
  node_1.appendChild(node_2);





  let footer = createCardFooter(quantity);

  let body = document.createElement("div");
  body.classList.add("card-body", "bg-body-secondary");
  body.append(imageTag, titleTag, priceTag, node_1, footer);

  return body;
}

function createCardFooter(quantity) {
  let input = createQuantityInput(quantity);
  let addToCart = document.createElement("a");
  addToCart.innerHTML = "Add To Cart";
  addToCart.type = "button";

  let footer = document.createElement("div");
  footer.classList.add("d-flex", "justify-content-between");
  footer.append(input, addToCart);

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

function createProductModal(image, number) {

  var node_1 = document.createElement('DIV');
  node_1.setAttribute('class', 'modal-header');

  var node_2 = document.createElement('H1');
  node_2.setAttribute('class', 'modal-title fs-5');
  node_2.setAttribute('id', 'exampleModalLabel');
  node_1.appendChild(node_2);

  var node_3 = document.createTextNode((new String("Modal title")));
  node_2.appendChild(node_3);

  var node_4 = document.createElement('BUTTON');
  node_4.setAttribute('type', 'button');
  node_4.setAttribute('class', 'btn-close');
  node_4.setAttribute('data-bs-dismiss', 'modal');
  node_4.setAttribute('aria-label', 'Close');
  node_1.appendChild(node_4);

  var node_5 = document.createElement('DIV');
  node_5.setAttribute('class', 'modal-body');

  let imageTag = document.createElement("img");
  imageTag.src = image;
  imageTag.classList.add("card-img-top", "img-fluid", "img-thumbnail");
  imageTag.alt = `Image de `;
  node_5.appendChild(imageTag)

  var node_6 = document.createElement('DIV');
  node_6.setAttribute('class', 'modal-footer');

  var node_7 = document.createElement('BUTTON');
  node_7.setAttribute('type', 'button');
  node_7.setAttribute('class', 'btn btn-secondary');
  node_7.setAttribute('data-bs-dismiss', 'modal');
  node_6.appendChild(node_7);

  var node_8 = document.createTextNode((new String("Close")));
  node_7.appendChild(node_8);

  var node_9 = document.createElement('BUTTON');
  node_9.setAttribute('type', 'button');
  node_9.setAttribute('class', 'btn btn-primary');
  node_6.appendChild(node_9);

  var node_10 = document.createTextNode((new String("Save changes")));
  node_9.appendChild(node_10);


  // document.getElementById("productModal").remove();
  document.getElementById("modalContent").appendChild(node_1);
}

function categoryIcon(category) {
  let icon;

  switch (category) {
    case "coolers":
      icon = "<i class='bi bi-fan'></i>";
      break;
    case "motherboards":
      icon = "<i class='bi bi-motherboard-fill'></i>";
      break;
    case "power supplies":
      icon = "<i class='bi bi-cpu-fill'></i>";
      break;
    case "processors":
      icon = "<i class='bi bi-pc'></i>";
      break;
    case "ram brackets":
      icon = "<i class='bi bi-nvme-fill'></i>";
      break;
    case "storage drives":
      icon = "<i class='bi bi-device-ssd-fill'></i>";
      break;
    case "video cards":
      icon = "<i class='bi bi-pci-card'></i>";
      break;

    default:
      icon = "<i class='bi bi-pc'></i>";
      break;
  }

  return icon;
}

function fetchData(path) {
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
          switch (path.substr(0, path.indexOf("/"))) {
            case "products":
              console.log(path)
              createProduct(element);
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
