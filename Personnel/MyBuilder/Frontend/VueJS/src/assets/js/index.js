import { getData } from "./helpers/data";
import { updateCartLength } from "./helpers/functions";
import { connect } from "./components/user/user";

export function main() {
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

export function getProducts(table = "cases") {
  document.getElementById("productsContainer").innerHTML = "";
  getData(`products/${table}`);
}
