const GRAPH = ['doughnut', 'pie', 'polarArea', 'radar'];
const API = {
  SUPERHERO_BASE_URL: 'https://www.superheroapi.com/api.php/73e979bccd93b759d8b54152e4411942/',
}
const KEYS = ['Biography', 'Appearance', 'Work', 'Connections'];

async function superheroSearch(name) {
  if (document.getElementById('herosCards').hasChildNodes()) {
    clearResults();
  }

  if (/\s/g.test(name)) {
    name.replace(/\s/g, '%20')
  }

  let data = await superheroAPI(name);
  let heros = [];

  heros.push(...data);

  heros.forEach(hero => {
    generateCard(hero);
  });

  if (document.getElementById('downloadBtn') !== null) {
    document.getElementById('downloadBtn').remove();
  }

  let button = document.createElement('button');
  button.classList.add('btn', 'btn-outline-success', 'ms-5');
  button.innerHTML = '<i class="fa-solid fa-download"></i>';
  button.setAttribute('id', 'downloadBtn');
  button.ariaDescription = 'Download all the data in a CSV file.'
  button.onclick = function () {
    jsonToCsv(heros, name);
  }

  document.getElementById('searchForm').appendChild(button);
}

function keyPressed(name, event) {
  if (event.keyCode == 13) {
    superheroSearch(name);
  }
}

function generateCard(hero) {
  let card = createCard(hero.id, hero.name, hero.image.url, hero.biography['full-name']);
  let modal = createModal(hero);
  let col = document.createElement('div');
  col.classList.add('col');
  col.appendChild(card);

  document.getElementById('herosCards').append(col, modal);
}

function createCard(id, name, url, fullName) {
  let image = createImage(name, url)
  let body = createCardBody(name, fullName);
  let card = document.createElement('div');
  card.classList.add('card', 'mw-75', 'h-100');
  card.setAttribute('type', 'button');
  card.setAttribute('data-bs-toggle', 'modal');
  card.setAttribute('data-bs-target', `#heroModal${id}`);
  card.append(image, body);

  return card;
}

function createCardBody(name, fullName) {
  let title = document.createElement('h5');
  title.classList.add('card-title');
  title.innerHTML = name;

  let text = document.createElement('small');
  text.classList.add('text-body-secondary');
  text.innerHTML = fullName;

  let body = document.createElement('div');
  body.classList.add('card-footer');
  body.append(title, text);

  return body;
}

function createModal(hero) {
  let image = createImage(hero.name, hero.image.url);
  let data = createModalData(hero);
  let body = createModalBody(image, data);
  let content = createModalContent(body);
  let dialog = createModalDialog(content);
  let modal = document.createElement('div');
  modal.classList.add('modal', 'fade');
  modal.id = `heroModal${hero.id}`;
  modal.tabIndex = '-1';
  modal.ariaLabel = `heroModal${hero.id}`;
  modal.ariaHidden = 'true';
  modal.appendChild(dialog);

  return modal;
}

function createModalDialog(content) {
  let dialog = document.createElement('div');
  dialog.classList.add('modal-dialog', 'modal-xl', 'modal-dialog-centered', 'modal-dialog-scrollable');
  dialog.appendChild(content);

  return dialog;
}

function createModalContent(body) {
  let content = document.createElement('div');
  content.classList.add('modal-content');
  content.appendChild(body);

  return content;
}
function createModalBody(image, data) {
  let innerBody = document.createElement('div');
  innerBody.classList.add('d-flex');
  innerBody.append(image, data);

  let body = document.createElement('div');
  body.classList.add('modal-body', 'd-flex', 'flex-column');
  body.append(innerBody);

  return body;
}

function createModalData(hero) {
  let bio = createModalBio(hero);
  let stats = createModalStats(hero.id, hero.biography['full-name'], hero.powerstats);
  stats.classList.add('d-flex', 'justify-content-center');
  let data = document.createElement('div');
  data.classList.add('ms-4', 'w-100');
  data.append(bio, stats);

  return data;
}

function createModalBio(hero) {
  let header = createModalHeader(hero.name, hero.biography.alignement);

  let alterEgo = document.createElement('span');
  alterEgo.classList.add('ms-3', 'text-muted', 'fs-6', 'fw-normal');
  alterEgo.innerHTML = hero.biography['alter-egos'];

  let fullName = document.createElement('h5');
  fullName.innerHTML = hero.biography['full-name'];
  fullName.appendChild(alterEgo);

  let aliases = document.createElement('small');
  aliases.classList.add('text-nowrap');
  hero.biography.aliases.forEach(alias => {
    aliases.innerHTML += `${alias}, `
  });

  let bio = document.createElement('div');
  bio.classList.add('d-flex', 'flex-column', 'align-items-start');
  bio.append(header, fullName, aliases);

  return bio;
}

function createModalHeader(name, alignement) {
  let icon = document.createElement('i');
  icon.classList.add('fs-1', 'me-2', 'fa-solid');

  if (alignement !== 'bad') {
    icon.classList.add('fa-circle-check', 'text-success');
  } else {
    icon.classList.add('fa-circle-xmark', 'text-danger');
  }

  let title = document.createElement('h1');
  title.innerHTML = name;

  let header = document.createElement('div');
  header.classList.add('d-flex', 'justify-content-start', 'align-items-center');
  header.append(icon, title);

  return header;
}

function createModalStats(id, name, powerstats) {
  let stats = document.createElement('canvas');
  stats.setAttribute('id', `chart${id}`);
  stats.classList.add('m-auto', 'w-75');

  new Chart(stats, {
    type: GRAPH[Math.floor(Math.random() * 3)],
    data: {
      labels: ['Intelligence', 'Strength', 'Speed', 'Durability', 'Power', 'Combat'],
      datasets: [{
        label: name,
        data: [powerstats.intelligence, powerstats.strength, powerstats.speed, powerstats.durability, powerstats.power, powerstats.combat],
        backgroundColor: [
          'rgb(255, 0, 0)',
          'rgb(0, 255, 0)',
          'rgb(0, 0, 255)',
          'rgb(255, 205, 86)',
          'rgb(0, 255, 0)',
          'rgb(255,20,147)'
        ],
        borderColor: 'rgb(0, 0, 0, 0)',
        hoverOffset: 4
      }]
    },
    options: {
      responsive: true
    }
  });

  return stats;
}

function createImage(name, url) {
  let image = document.createElement('img');
  image.src = url;
  image.alt = `${name} image`;

  return image;
}

function clearResults() {
  document.getElementById('herosCards').innerHTML = '';
  document.getElementById('floatingInputGroup').value = '';
}

async function superheroAPI(name) {
  let response = await (await fetch(`${API.SUPERHERO_BASE_URL}/search/${name}`)).json();

  if (response.response !== 'success') {
    document.getElementsByClassName('invalid-feedback')[0].innerHTML = "Sorry, we can't find this hero.";
  } else {
    let button = document.createElement('button');
    button.type = 'button';
    button.classList.add('btn', 'btn-secondary');
    button.onclick = function () {
      superheroSearch(name);
    }
    button.innerHTML = `${name} (${response.results.length})`;

    document.getElementById('searchHistory').appendChild(button);
  }

  return response.results;
}

function jsonToCsv(heros, name) {
  let header = Object.keys(heros[0]);
  let headerString = header.join(',');
  let replacer = (key, value) => value ?? '';
  let rowItems = heros.map((row) =>
    header
      .map((fieldName) => JSON.stringify(row[fieldName], replacer))
      .join(',')
  );
  let csv = [headerString, ...rowItems].join('\r\n');

  saveCSV(csv, name);
}

function saveCSV(csv, name) {
  let date = new Date();
  let link = document.createElement("a");
  let file = new Blob([csv], { type: 'text/plain' });
  link.href = URL.createObjectURL(file);
  link.download = `${name}_${date.toLocaleDateString()}_${date.getHours()}:${date.getMinutes()}.csv`;
  link.click();

  URL.revokeObjectURL(link.href);
}