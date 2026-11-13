function createRow(product) {
  let row = document.createElement("tr");
  row.append(createImage(product.imageURL, product.name), createLabel(product.name), createLabel(product.price), createButton(getCart().findIndex(item => item.name === product.name)));
  // createInput(0, product.quantity)

  document.getElementById("cartContainer").appendChild(row);
}

function createImage(imageURL, name) {
  let image = document.createElement("img");
  image.src = imageURL;
  image.classList.add("card-img-top");
  image.style.width = "100px";
  image.style.height = "100px";
  image.alt = `Image of ${name}`;

  return createData(image);
}

function createLabel(text) {
  let label = document.createElement("h5");
  label.innerHTML = text;

  return createData(label);
}

// function createInput(id, quantity) {
//   let input = document.createElement("input");
//   input.id = `quantityInput${id}`;
//   input.classList.add("form-control", "rounded", "bg-dark", "text-white", "text-center", "fs-3", "w-50");
//   input.type = "number";
//   input.value = quantity;
//   input.required = true;
//   input.min = 0;

//   return createData(input);
// }

function createButton(index) {
  let button = document.createElement("button");
  button.classList.add("btn", "fs-5");
  button.innerHTML = "<i class='bi bi-trash3-fill'></i>";
  button.title = "Remove this product from your cart";
  button.onclick = function () {
    emptyCart(index)
  }

  return createData(button);
}

function createData(element) {
  let td = document.createElement("td");
  td.appendChild(element);

  return td;
}