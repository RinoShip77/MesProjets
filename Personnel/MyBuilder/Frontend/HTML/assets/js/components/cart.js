function addToCart(product, quantity = 1) {
  let cart = (localStorage.getItem("cart") !== null) ? JSON.parse(localStorage.getItem("cart")) : [];
  let newProduct = {
    name: product.name,
    imageURL: product.imageURL,
    price: product.price
  }

  cart.push(newProduct);
  document.getElementById("cartQuantity").innerHTML = cart.length;
  localStorage.setItem("cart", JSON.stringify(cart));
  sendToast(newProduct.imageURL, newProduct.name, quantity);

  // if (quantity !== 1) {
  //   // Add the cart
  //   cart.forEach(product => {
  //     post("orders/add", product)
  //   });
  // } else {
  //   // Add ONLY the new product
  //   post("orders/add", newProduct)
  // }

  updateCartLenght();
}

function checkout() {
  let email = (sessionStorage.getItem("user") !== null) ? JSON.parse(sessionStorage.getItem("user")).email : "";

  postData("orders/checkout",
    {
      price: "59.00",
      user: email
    }
  );
}

function updateCheckout(price, quantity = 1) {
  let products = (localStorage.getItem("checkoutProducts") !== null) ? JSON.parse(localStorage.getItem("checkoutProducts")) : [];
  let newPrice = {
    price: price,
    quantity: quantity
  }

  products.push(newPrice);
  localStorage.setItem("checkoutProducts", JSON.stringify(products));
}

function setCheckoutLink() {
  // if (localStorage.getItem("cart") !== null) {
  //   let email = (localStorage.getItem("user") !== null) ? JSON.parse(sessionStorage.getItem('user')).email : "johndoe@gmail.com";
  //   let checkout = {
  //     products: JSON.parse(localStorage.getItem("checkoutProducts")),
  //     user: email
  //   }

  //   post("orders/checkout", checkout);
  //   console.log(checkout);
  //   setTimeout(() => {
  //     document.getElementById("checkoutLink").href = sessionStorage.getItem("checkoutLink");
  //   }, 1000);
  // }
}

function resetCheckout() {
  // localStorage.removeItem('cart');
  // localStorage.removeItem('checkoutProduct');
  // localStorage.removeItem('checkoutLink');
}