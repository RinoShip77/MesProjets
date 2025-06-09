function createCategoryFilters(category) {
  if (window.innerWidth > 1110) {
    createCategorySwitch(category);
  } else {
    createCategoryButtons(category);
  }
}