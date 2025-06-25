export function createProductModal(product) {
  let node_1 = document.createElement("DIV");
  node_1.classList.add("modal", "fade");
  node_1.id = `productModal${product.id}`;
  node_1.tabIndex = "-1";
  node_1.setAttribute("aria-labelledby", product.name);

  let node_2 = document.createElement("DIV");
  node_2.classList.add("modal-dialog");
  node_1.appendChild(node_2);

  let node_3 = document.createElement("DIV");
  node_3.classList.add("modal-content");
  node_2.appendChild(node_3);

  let node_4 = document.createElement("DIV");
  node_4.classList.add("modal-header");
  node_3.appendChild(node_4);

  let node_5 = document.createElement("H1");
  node_5.innerHTML = product.name;
  node_5.classList.add("modal-title", "fs-5");
  node_5.id = "exampleModalLabel";
  node_4.appendChild(node_5);

  let node_7 = document.createElement("BUTTON");
  node_7.type = "button";
  node_7.classList.add("btn-close");
  node_7.setAttribute("data-bs-dismiss", "modal");
  node_7.setAttribute("aria-label", "Close");
  node_4.appendChild(node_7);

  let node_8 = document.createElement("DIV");
  node_8.classList.add("modal-body");
  node_3.appendChild(node_8);

  let node_9 = document.createElement("DIV");
  node_9.classList.add("modal-footer");
  node_3.appendChild(node_9);

  let node_10 = document.createElement("BUTTON");
  node_10.type = "button";
  node_10.classList.add("btn", "btn-secondary");
  node_10.setAttribute("data-bs-dismiss", "modal");
  node_9.appendChild(node_10);

  let node_11 = document.createTextNode((new String("Close")));
  node_10.appendChild(node_11);

  let node_12 = document.createElement("BUTTON");
  node_12.type = "button";
  node_12.classList.add("btn", "btn-primary");
  node_9.appendChild(node_12);

  let node_13 = document.createTextNode((new String("Save changes")));
  node_12.appendChild(node_13);

  document.body.appendChild(node_1);
}