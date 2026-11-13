import { getProducts } from "../../index";
import { categoryIcon, generateTooltip } from "../../helpers/functions";

export function createCategoryDropdown(category) {
  let link = document.createElement("a");
  link.type = "button";
  link.innerHTML = `${category.name} ${categoryIcon(category.name)}`;
  link.classList.add("dropdown-item");
  link.setAttribute("data-bs-toggle", "tooltip");
  link.setAttribute("data-bs-title", `${category.count}`);
  link.setAttribute("data-bs-placement", "right");
  generateTooltip(link);
  link.onclick = function () {
    getProducts(category.name.replace(" ", "_").toLowerCase());
  }

  let dropdownItem = document.createElement("li");
  dropdownItem.appendChild(link);

  document.getElementById("categoriesDropdown").appendChild(dropdownItem);
}