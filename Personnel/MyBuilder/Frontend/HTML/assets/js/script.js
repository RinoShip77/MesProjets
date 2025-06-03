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
  input.id = `${category.Tables_in_my_builder}Switch`;
  input.classList.add("form-check-input", "me-3");
  input.name = "categorySwitch";
  input.type = "radio";
  input.role = "switch";
  input.onchange = function () {
    getProducts(category.Tables_in_my_builder);
  }

  let label = document.createElement("label");
  label.innerHTML = `${category.Tables_in_my_builder.replace(/_/g, " ")} ${categoryIcon(category.Tables_in_my_builder.replace(/_/g, " "))}`;
  label.classList.add("form-check-label", "text-capitalize");
  label.setAttribute("for", `${category.Tables_in_my_builder}Switch`);

  let container = document.createElement("div");
  container.classList.add("form-check", "form-switch", "d-flex", "align-items-center", "my-3");
  container.append(input, label);

  document.getElementById("categoriesContainer").appendChild(container);
}

function createCategoryDropdown(category) {
  let link = document.createElement("a");
  link.innerHTML = `${category.Tables_in_my_builder.replace(/_/g, " ")} ${categoryIcon(category.Tables_in_my_builder.replace(/_/g, " "))}`;
  link.classList.add("dropdown-item", "text-capitalize");
  link.onclick = function () {
    getProducts(category.Tables_in_my_builder);
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
  modalLink.append(createCardBody(product.imageURL, product.name, product.price, 2));
  createProductModal(product);
  
  let column = document.createElement("div");
  column.classList.add("col");
  column.appendChild(modalLink);
  
  document.getElementById("productsContainer").appendChild(column);
}

function createCardBody(image, title, price, quantity) {
  let imageTag = document.createElement("img");
  imageTag.src = image;
  imageTag.onerror = function () { this.src = "https://static-00.iconduck.com/assets.00/no-image-icon-512x512-lfoanl0w.png" };
  imageTag.classList.add("card-img-top", "img-fluid", "img-thumbnail");
  imageTag.alt = `Image de ${title}`;

  let titleTag = document.createElement("h4");
  titleTag.innerHTML = title;
  titleTag.classList.add("card-title", "pt-2");

  let priceTag = document.createElement("p");
  priceTag.innerHTML = price;
  priceTag.classList.add("text-body-secondary");

  let footer = createCardFooter(quantity);

  let body = document.createElement("div");
  body.classList.add("card-body", "d-flex", "flex-column", "justify-content-between", "bg-body-secondary");
  body.append(imageTag, titleTag, priceTag, footer);

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
      data.slice(0, 10).forEach(element => {
        if (path.includes("/")) {
          switch (path.substr(0, path.indexOf("/"))) {
            case "products":
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
