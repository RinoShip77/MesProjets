import { postData } from "../../helpers/data";
import { generateTooltip } from "../../helpers/functions";

export function login(username, password) {
  let user = {
    email: username,
    password: password
  };

  if (username.length === 0 && password.length === 0) {
    user.email = "johndoe@gmail.com";
    user.password = "1234";
  }

  postData("users/login", user);
}

export function connect() {
  if (sessionStorage.getItem("user") !== null) {
    document.getElementById("userStatus").classList.toggle("d-none");
    document.getElementById("logoutLink").classList.toggle("d-none");
    document.getElementById("loginLink").setAttribute("data-bs-toggle", "tooltip");
    document.getElementById("loginLink").setAttribute("data-bs-title", `${JSON.parse(sessionStorage.getItem("user")).firstName} ${JSON.parse(sessionStorage.getItem("user")).lastName}`);
    document.getElementById("loginLink").setAttribute("data-bs-placement", "bottom");

    generateTooltip(document.getElementById("loginLink"));
  }
}

export function disconnect() {
  document.getElementById("logoutLink").classList.toggle("d-none");
  sessionStorage.removeItem("user");
  location.reload();
}

export function signup(firstName, lastName, email, password) {
  let user = {
    firstName: firstName,
    lastName: lastName,
    email: email,
    password: password
  }

  postData("users/add", user);
}