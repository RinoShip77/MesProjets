function addToCart(product, quantity = 1) {
  let cart = (localStorage.getItem("cart") !== null) ? JSON.parse(localStorage.getItem("cart")) : [];
  cart.push(product);

  sendToast(product.imageURL, product.name, quantity);
  document.getElementById("cartQuantity").innerHTML = cart.length;
  localStorage.setItem("cart", JSON.stringify(cart));
}

function login(username = "johndoe@gmail.com", password = "1234") {
  let user = {
    email: username,
    password: password
  };

  postData("users/login", user);
}

function connect() {
  if (sessionStorage.getItem("user") !== null) {
    document.getElementById("userStatus").classList.toggle("d-none");
    document.getElementById("logoutLink").classList.toggle("d-none");
    document.getElementById("loginLink").setAttribute("data-bs-toggle", "tooltip");
    document.getElementById("loginLink").setAttribute("data-bs-title", `${JSON.parse(sessionStorage.getItem("user")).firstName} ${JSON.parse(sessionStorage.getItem("user")).lastName}`);
    document.getElementById("loginLink").setAttribute("data-bs-placement", "bottom");

    generateTooltip(document.getElementById("loginLink"));
  }
}

function disconnect() {
  document.getElementById("logoutLink").classList.toggle("d-none");
  sessionStorage.removeItem("user");
  location.reload();
}

function switchTheme() {
  let theme = (sessionStorage.getItem("theme") !== null) ? sessionStorage.getItem("theme") : "light";

  switch (theme) {
    case "light":
      document.getElementById("themeSwitcher").classList.replace("bi-moon-stars-fill", "bi-sun-fill");
      document.body.setAttribute("data-bs-theme", "dark");
      sessionStorage.setItem("theme", "dark");
      break;

    case "dark":
      document.getElementById("themeSwitcher").classList.replace("bi-sun-fill", "bi-moon-stars-fill");
      document.body.setAttribute("data-bs-theme", "light");
      sessionStorage.setItem("theme", "light");
      break;
  }
}

function categoryIcon(category) {
  let icon;

  switch (category) {
    case "Coolers":
      icon = "fan";
      break;
    case "Motherboards":
      icon = "motherboard-fill";
      break;
    case "Power supplies":
      icon = "battery-charging";
      break;
    case "Processors":
      icon = "cpu-fill";
      break;
    case "Ram brackets":
      icon = "nvme-fill";
      break;
    case "Storage drives":
      icon = "device-ssd-fill";
      break;
    case "Video cards":
      icon = "pci-card";
      break;

    default:
      icon = "pc";
      break;
  }

  return `<i class="bi bi-${icon}"></i>`;
}

function generateTooltip(element) {
  return new bootstrap.Tooltip(element, {
    container: document.body
  })
}

function sendToast(image, name, quantity) {
  document.getElementById("cartToastImage").src = image;
  document.getElementById("cartToastImage").alt = name;
  document.getElementById("cartToastTitle").innerHTML = name;
  document.getElementById("cartToastMessage").innerHTML = `${name} was added ${quantity} time.`;

  if (quantity > 1) {
    document.getElementById("cartToastMessage").innerHTML = document.getElementById("toastMessage").innerHTML.slice(-1);
    document.getElementById("cartToastMessage").innerHTML += `${name} was added ${quantity} times.`;
  }

  bootstrap.Toast.getOrCreateInstance(document.getElementById("cartToast")).show();
}