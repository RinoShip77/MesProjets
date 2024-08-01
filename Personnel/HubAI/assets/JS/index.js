$(document).ready(function () {
  let date = new Date();
  let email = 'olivier.bourgault@parl.gc.ca';

  $('#currentYear').text(date.getFullYear());
  $('#emailLink').attr('href', `mailto:${email}`);
  colorSwitch(window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light');
});

function colorSwitch(value) {
  if (value === 'default') {
    value = window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
  }

  document.body.setAttribute('data-bs-theme', value);
}

function loadFile() {
  $('#HTMLcontent').empty();
  $('#HTMLcontent').load(`pages/home.html`);
}