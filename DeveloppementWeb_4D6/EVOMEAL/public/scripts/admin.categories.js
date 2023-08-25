//Provient d'ici:
//https://symfony.com/doc/current/form/form_collections.html#allowing-new-tags-with-the-prototype

const addFormToCollection = (e) => {
  const collectionHolder = document.querySelector(
    "." + e.currentTarget.dataset.collectionHolderClass
  );

  const category = document.createElement("li");

  category.innerHTML = collectionHolder.dataset.prototype.replace(
    /__name__/g,
    collectionHolder.dataset.index
  );

  collectionHolder.appendChild(category);

  collectionHolder.dataset.index++;
};

document.querySelectorAll(".add_category_link").forEach((btn) => {
  btn.addEventListener("click", addFormToCollection);
});
