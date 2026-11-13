function createCategorySwitch(category) {
  let input = document.createElement("input");
  input.id = `${category.name}Switch`;
  input.classList.add("form-check-input", "me-3");
  input.name = "categoryFilters";
  input.type = "radio";
  input.role = "switch";
  input.onchange = function () {
    getProducts(category.name.replace(" ", "_").toLowerCase());
  }

  let label = document.createElement("label");
  label.innerHTML = `${category.name} ${categoryIcon(category.name)}`;
  label.classList.add("form-check-label");
  label.setAttribute("for", `${category.name}Switch`);
  label.setAttribute("data-bs-toggle", "tooltip");
  label.setAttribute("data-bs-title", `${category.count}`);
  label.setAttribute("data-bs-placement", "right");
  generateTooltip(label);

  let container = document.createElement("div");
  container.classList.add("form-check", "form-switch", "d-flex", "align-items-center", "my-3");
  container.append(input, label);

  document.getElementById("categoriesContainer").appendChild(container);
}