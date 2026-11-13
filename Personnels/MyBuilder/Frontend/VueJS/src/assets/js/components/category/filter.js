import { createCategorySwitch } from "./switch";
import { createCategoryButtons } from "./button";

export function createCategoryFilters(category) {
  if (window.innerWidth > 1110) {
    createCategorySwitch(category);
  } else {
    createCategoryButtons(category);
  }
}