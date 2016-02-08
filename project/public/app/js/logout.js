$('#logout').on('click', function(e){
  e.preventDefault();
  logoutService.logout().done(function(data){
      window.location = logoutService.baseUrl;
  });
});
