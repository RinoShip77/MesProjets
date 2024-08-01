$(document).ready(function () {
  let date = new Date();

  $('#currentYear').text(date.getFullYear());
  $('#emailLink').attr('href', 'mailto:olivier.bourgault@parl.gc.ca')
  colorSwitch(window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light');
});

function colorSwitch(value) {
  if (value === 'default') {
    value = window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
  }

  document.body.setAttribute('data-bs-theme', value);
}

function loadFiles(name) {
  $('#HTMLcontent').empty();
  loadHTML(name);
  
  if (name !== 'home') {
    loadJS(`pages/JS/${name}`);
  }
}

function loadHTML(file) {
  $('#HTMLcontent').load(`pages/HTML/${file}.html`);
};

function loadJS(path) {
  $('#pageBody').append(`<script src='${path}.js'></script>`);
}