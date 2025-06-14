const BASE_URL = "http://localhost:5000/";

main();

function main() {
  getData();
  getProducts();
  updateCartLength();  

  if (sessionStorage.getItem("user") !== null)
    connect();

  if (localStorage.getItem("cart") !== null) {
    if (JSON.parse(localStorage.getItem("cart")).length > 0) {
      document.getElementById("cartQuantity").classList.toggle("d-none");
      document.getElementById("cartQuantity").innerHTML = JSON.parse(localStorage.getItem("cart")).length;
    }
  }
}

function getProducts(table = "cases") {
  document.getElementById("productsContainer").innerHTML = "";
  getData(`products/${table}`);
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
