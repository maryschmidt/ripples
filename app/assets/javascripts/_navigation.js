$(document).ready(function() {
  if(location.pathname == '/') {
    $('.nav-links a[href^="/pages/results"]').addClass('active');
  } else {
    $('.nav-links a[href^="/pages/' + location.pathname.split("/")[2] + '"]').addClass('active');
  }
});
