function addToCart(product, quantity = 1) {
  let cart = (localStorage.getItem("cart") !== null) ? JSON.parse(localStorage.getItem("cart")) : [];
  let newProduct = {
    name: product.name,
    imageURL: product.imageURL,
    price: product.price
  }

  cart.push(newProduct);
  localStorage.setItem("cart", JSON.stringify(cart));
  sendToast(newProduct.imageURL, newProduct.name, quantity);


  if (cart.length <= 1)
    location.reload();
  else
    updateCartLength();
}

function checkout() {
  let email = (sessionStorage.getItem("user") !== null) ? JSON.parse(sessionStorage.getItem("user")).email : "";

  if (localStorage.getItem("cart") !== null) {
    postData("orders/checkout",
      {
        price: calculateTotal(JSON.parse(localStorage.getItem("cart"))),
        user: email
      }
    );
  } else {
    document.getElementById("warningToastMessage").innerHTML = "You must add a product to your cart.";
    bootstrap.Toast.getOrCreateInstance(document.getElementById("warningToast")).show();
  }
}