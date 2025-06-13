function get(path = "categories") {
  fetch(BASE_URL + path)
    .then(response => {
      if (response.ok) {
        return response.json();
      } else {
        throw new Error("Network response was not ok");
      }
    })
    .then(data => {
      data.forEach(element => {
        if (path.includes("/")) {
          switch (path.substring(0, path.indexOf("/"))) {
            case "products":
              (element) ? createProduct(element) : genratePlaceholder(25);
              break;
            case "users":
              // createUser(element);
              break;
          }
        } else {
          createCategoryDropdown(element);
          createCategoryFilters(element);
        }
      });
    })
    .catch(error => {
      genratePlaceholder(25);
      console.error("There was a problem with the fetch operation:", error);
    });
}

function post(path, data) {
  fetch(BASE_URL + path, {
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
            console.log("hidden");
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
        if(path === "orders/add") {
          updateCheckout(data.priceID);
        } else {
          sessionStorage.setItem("checkoutLink", data);
        }
      }
    })
    .catch((error) => {
      console.error("Error:", error);
    });
}