import { postData } from "../../helpers/data";
import { generateTooltip } from "../../helpers/functions";

export function login(username = "johndoe@gmail.com", password = "1234") {
  let user = {
    email: username,
    password: password
  };

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