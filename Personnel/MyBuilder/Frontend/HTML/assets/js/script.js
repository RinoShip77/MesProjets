
main();

function main() {
  fetchData();
}

function createElement(element) {
  let container = document.createElement('div');
  container.classList.add('col');

  let card = document.createElement('div');
  card.classList.add('card', 'h-100');
  container.appendChild(card);

  let image = document.createElement('img');
  image.src = element.imageURL;
  image.classList.add('card-img-top');
  image.setAttribute('alt', '...');
  card.appendChild(image);

  let body = document.createElement('div');
  body.classList.add('card-body');
  card.appendChild(body);

  let title = document.createElement('h5');
  title.innerHTML = 'Card title';
  title.classList.add('card-title');
  body.appendChild(title);

  let footer = document.createElement('div');
  footer.classList.add('card-footer');
  card.appendChild(footer);

  let price = document.createElement('small');
  price.innerHTML = element.price;
  price.classList.add('text-body-secondary');
  footer.appendChild(price);

  document.getElementById("productsContainer").appendChild(container);
  console.log(element)
}

function fetchData(url = "http://localhost:5000/products/cases") {
  fetch(url)
    .then(response => {
      if (response.ok) {
        return response.json();
      } else {
        throw new Error('Network response was not ok');
      }
    })
    .then(data => {
      data.forEach(element => {
       createElement(element);
      });
    })
    .catch(error => console.error('There was a problem with the fetch operation:', error));
}
