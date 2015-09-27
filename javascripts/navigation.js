$(document).ready(function() {
  if(location.pathname == '/ripples/') {
    $('.nav-links a[href="/ripples/"]').addClass('active');
  } else {
    $('.nav-links a[href^="/ripples/' + location.pathname.split("/")[2] + '"]').addClass('active');
  }
});
