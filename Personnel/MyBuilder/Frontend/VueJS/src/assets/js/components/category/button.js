import { getProducts } from "../../index";
import { categoryIcon } from "../../helpers/functions";
import { generateTooltip } from "../../helpers/functions";

export function createCategoryButtons(category) {
  let input = document.createElement("input");
  input.id = `${category.name}Buttons`;
  input.classList.add("btn-check");
  input.name = "categoryFilters";
  input.type = "radio";
  input.onchange = function () {
    getProducts(category.name.replace(" ", "_").toLowerCase());
  }

  let label = document.createElement("label");
  label.innerHTML = `${categoryIcon(category.name)}`;
  label.classList.add("btn", "fs-3");
  label.setAttribute("for", `${category.name}Buttons`);
  label.setAttribute("data-bs-toggle", "tooltip");
  label.setAttribute("data-bs-title", `${category.name} - ${category.count}`);
  label.setAttribute("data-bs-placement", "bottom");
  generateTooltip(label);

  document.getElementById("categoriesContainer").parentElement.classList.add("text-center", "mb-3");
  document.getElementById("categoriesContainer").append(input, label);
}