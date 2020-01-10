$(document).ready(function(){
  $('#warning').click(function(event){
    if ((confirm("Are you sure?")) == false) {
      event.preventDefault()
    }
  });
});
