$(document).ready(function() {
  $("#new_user").on("click", function(event){
    console.log("You clicked it.");
    event.preventDefault();
    $.get("/create", function(response) {
      $(".container").append(response);
    });
  });
});
