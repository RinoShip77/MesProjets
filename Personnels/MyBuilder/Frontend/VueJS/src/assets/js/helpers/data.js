import { createProduct } from "../components/product/card";
import { generatePlaceholder } from "../components/product/placeholder";
import { createCategoryDropdown } from "../components/category/dropdown";
import { createCategoryFilters } from "../components/category/filter";
import { connect } from "../components/user/user";
import CONSTANTS from "./constants";
import { isAdmin } from "./functions";
import { createRow as createAdminProduct } from "../components/product/admin";

export function getData(path = "categories") {
  fetch(CONSTANTS.SERVER_URL + path)
    .then(response => {
      if (response.ok) {
        return response.json();
      } else {
        throw new Error("Network response was not ok");
      }
    })
    .then(data => {
      if (!path.includes("users") || !path.includes("orders")) {
        data.forEach(element => {
          if (path.includes("/")) {
            switch (path.substring(0, path.indexOf("/"))) {
              case "products":
                if (!isAdmin()) {
                  (element) ? createProduct(element) : generatePlaceholder(25);
                } else {
                  createAdminProduct(element);
                }
                break;
              case "users":
                // createUser(element);
                break;
            }
          } else {
            if (!isAdmin()) {
              createCategoryDropdown(element);
              createCategoryFilters(element);
            }
          }
        });
      } else {
        //TODO: Manage get request for users and orders
      }
    })
    .catch(error => {
      generatePlaceholder(25);
      console.error("There was a problem with the fetch operation:", error);
    });
}

export function postData(path, data) {
  fetch(CONSTANTS.SERVER_URL + path, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(data),
  })
    .then((response) => {
      if (response.ok) {
        return response.json();
      } else {
        throw new Error("Network response was not ok");
      }
    })
    .then((data) => {
      if (path.includes("users")) {
        if (!data.message.includes("Bad")) {
          document.getElementById("loginToast").classList.add("bg-success");
          document.getElementById("loginToast").classList.remove("bg-danger");
          bootstrap.Modal.getOrCreateInstance(document.getElementById("loginModal")).hide();
          connect();
          document.getElementById("loginToast").addEventListener('hidden.bs.toast', () => {
            location.reload();
          });

          sessionStorage.setItem("user", JSON.stringify(data.user));
        } else {
          document.getElementById("loginToast").classList.add("bg-danger");
          document.getElementById("loginToast").classList.remove("bg-success");
        }

        document.getElementById("loginToastMessage").innerHTML = data.message;
        bootstrap.Toast.getOrCreateInstance(document.getElementById("loginToast")).show();
      } else {
        location.assign(data);
      }
    })
    .catch((error) => {
      console.error("Error:", error);
    });
}