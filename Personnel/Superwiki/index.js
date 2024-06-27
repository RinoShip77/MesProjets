$(document).ready(function() {
  let date = new Date();

  $('#currentYear').text(date.getFullYear());
  $('#emailLink').attr('href', 'mailto:olivier.bourgault@parl.gc.ca')
});

function loadHTML(file) {
  //$('#HTMLcontent').empty();
  //$('#HTMLcontent').load(`pages/${file}.html`);
};