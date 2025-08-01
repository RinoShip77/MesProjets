export function createRow(product) {
  let row = document.createElement("tr");
  row.append(createImage(product.imageURL, product.name), createLabel(product.name), createLabel(product.quantityInStock), createLabel(product.price), createButtons());

  document.getElementById("adminProductsContainer").appendChild(row);
}

export function createImage(imageURL, name) {
  let image = document.createElement("img");
  image.src = imageURL;
  image.classList.add("card-img-top");
  image.style.width = "50px";
  image.style.height = "50px";
  image.alt = `Image of ${name}`;

  return createData(image);
}

export function createLabel(text) {
  let label = document.createElement("p");
  label.innerHTML = text;

  return createData(label);
}

export function createButtons() {
  let deleteButton = document.createElement("button");
  deleteButton.classList.add("btn");
  deleteButton.innerHTML = `<i class="bi bi-trash3-fill"></i>`;
  deleteButton.title = "Remove this product";
  deleteButton.onclick = function () {
    // TODO: delete a product
  }
  
  let updateButton = document.createElement("button");
  updateButton.classList.add("btn");
  updateButton.innerHTML = `<i class="bi bi-pencil-square"></i>`;
  updateButton.title = "Update this product";
  updateButton.onclick = function () {
    // TODO: update a product
  }

  let container = document.createElement("div");
  container.classList.add("d-flex");
  container.append(deleteButton, updateButton);

  return createData(container);
}

export function createData(element) {
  let td = document.createElement("td");
  td.append(element);

  return td;
}