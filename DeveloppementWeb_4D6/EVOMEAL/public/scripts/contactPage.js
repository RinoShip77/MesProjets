$(document).ready(function () {
  $('#feedbackButton').on('click', function (event) {
    event.preventDefault();
    $('#requestSubject').val($('#requestSubject').val().charAt(0).toUpperCase() + $('#requestSubject').val().slice(1));
    $('#requestBody').val($('#requestBody').val().charAt(0).toUpperCase() + $('#requestBody').val().slice(1));

    window.location = 'mailto:1875009@cstj.qc.ca?subject=' + $('#requestSubject').val() + '&body=' + $('#requestBody').val();
  });
});