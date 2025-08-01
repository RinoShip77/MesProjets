export function generatePlaceholder(number) {
  for (let index = 0; index < number; index++) {
    let content_1 = document.createElement("SPAN");
    content_1.classList.add("placeholder", "col-6");

    let content_2 = document.createElement("SPAN");
    content_2.classList.add("placeholder", "col-7");

    let content_3 = document.createElement("SPAN");
    content_3.classList.add("placeholder", "col-4");

    let content_4 = document.createElement("SPAN");
    content_4.classList.add("placeholder", "col-4");

    let content_5 = document.createElement("SPAN");
    content_5.classList.add("placeholder", "col-6");

    let content_6 = document.createElement("SPAN");
    content_6.classList.add("placeholder", "col-8");

    let text = document.createElement("P");
    text.classList.add("card-text", "placeholder-glow");
    text.append(content_2, content_3, content_4, content_5, content_6);

    let image = document.createElement("IMG");
    image.src = "https://assets.streamlinehq.com/image/private/w_300,h_300,ar_1/f_auto/v1/icons/c5/no-image-px759fvb06aw65eaaqpopg.png/no-image-ousebmandtg1ym1w6nntl.png?_a=DATAdtAAZAA0";
    image.classList.add("card-img-top", "w-75", "mx-auto", "pt-3");
    image.alt = "N/A";

    let title = document.createElement("H5");
    title.classList.add("card-title", "placeholder-glow");
    title.appendChild(content_1);

    let body = document.createElement("DIV");
    body.classList.add("card-body");
    body.append(title, text);

    let card = document.createElement("DIV");
    card.classList.add("card");
    card.setAttribute("aria-hidden", "true");
    card.append(image, body);

    let container = document.createElement("div");
    container.classList.add("col");
    container.appendChild(card);

    (document.getElementById("productsContainer")) && document.getElementById("productsContainer").appendChild(container);
  }
}