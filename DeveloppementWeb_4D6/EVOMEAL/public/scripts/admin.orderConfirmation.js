const dropdown = document.getElementById("orderStatusSelect");

dropdown.addEventListener("change", function() {
  document.getElementById("orderStatusForm").submit();
});