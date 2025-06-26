import { calculateSubtotal, calculateTaxes, calculateTotal, getCart, sendToast, updateCartLength } from "../../helpers/functions";
import { createRow } from "./modal";
import { postData } from "../../helpers/data";
import CONSTANTS from "../../helpers/constants";

export function openCart() {
  let cart = getCart();

  document.getElementById("subtotalLabel").innerHTML = `$${calculateSubtotal(cart)}`;
  document.getElementById("gstLabel").innerHTML = `$${calculateTaxes(calculateSubtotal(cart), CONSTANTS.GST)}`;
  document.getElementById("qstLabel").innerHTML = `$${calculateTaxes(calculateSubtotal(cart), CONSTANTS.QST)}`;
  document.getElementById("deliveryLabel").innerHTML = `$${calculateTaxes(calculateSubtotal(cart), CONSTANTS.SHIPPING_RATE)}`;
  document.getElementById("totalLabel").innerHTML = `$${calculateTotal(calculateSubtotal(cart), calculateTaxes(calculateSubtotal(cart), CONSTANTS.GST), calculateTaxes(calculateSubtotal(cart), CONSTANTS.QST), calculateTaxes(calculateSubtotal(cart), CONSTANTS.SHIPPING_RATE))}`;

  if (cart.length > 0) {
    document.getElementById("cart").classList.remove("d-none");
    document.getElementById("emptyCartMessage").classList.add("d-none");
  } else {
    document.getElementById("cart").classList.add("d-none");
    document.getElementById("emptyCartMessage").classList.remove("d-none");
  }

  updateCart();
}

export function emptyCart(index = null) {
  if (index !== null) {
    let cart = getCart();
    cart.splice(index, 1);

    localStorage.setItem("cart", JSON.stringify(cart));
  } else {
    localStorage.removeItem("cart");
  }

  location.reload();
}

export function updateCart() {
  document.getElementById("cartContainer").innerHTML = "";

  getCart().forEach(product => {
    createRow(product);
  });
}

export function addToCart(product, quantity = 1) {
  let cart = getCart();
  let newProduct = {
    name: product.name,
    imageURL: product.imageURL,
    price: product.price,
    quantity: quantity
  }

  cart.push(newProduct);
  localStorage.setItem("cart", JSON.stringify(cart));
  sendToast(newProduct.imageURL, newProduct.name, quantity);
  createRow(newProduct);

  if (cart.length <= 1)
    location.reload();
  else
    updateCartLength();
}

export function checkout() {
  let email = (sessionStorage.getItem("user") !== null) ? JSON.parse(sessionStorage.getItem("user")).email : "";
  let cart = JSON.parse(localStorage.getItem("cart"));

  if (localStorage.getItem("cart") !== null) {
    postData("orders/checkout",
      {
        price: calculateTotal(calculateSubtotal(cart), calculateTaxes(calculateSubtotal(cart), GST), calculateTaxes(calculateSubtotal(cart), QST), calculateTaxes(calculateSubtotal(cart), SHIPPING_RATE)) * 100,
        user: email,
        statusURL: `${location.origin}/pages`
      }
    );
  } else {
    document.getElementById("warningToastMessage").innerHTML = "You must add a product to your cart.";
    bootstrap.Toast.getOrCreateInstance(document.getElementById("warningToast")).show();
  }
}