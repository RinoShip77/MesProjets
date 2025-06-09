function createProduct(product) {
  let modalLink = document.createElement("a");
  modalLink.type = "button";
  modalLink.classList.add("card", "text-decoration-none", "shadow", "rounded-0", "rounded-top", "bg-body-secondary");
  modalLink.style.height = "20rem";
  modalLink.setAttribute("data-bs-toggle", "modal");
  modalLink.setAttribute("data-bs-target", `#productModal${product.id}`);
  modalLink.append(createCardBody(product));
  createProductModal(product);

  let column = document.createElement("div");
  column.classList.add("col");
  column.append(modalLink, createCardFooter(product));

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
  body.classList.add("card-body");
  body.append(imageTag, titleTag, priceTag);

  return body;
}

function createCardFooter(product) {
  let footer = document.createElement("button");
  footer.classList.add("btn", "btn-success", "rounded-0", "rounded-bottom", "w-100");
  footer.type = "button";
  footer.innerHTML = "Add To Cart";
  footer.onclick = function () {
    addToCart(product);
  }

  return footer;
}