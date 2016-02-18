(function($){
  var themeLink = $('#main-theme');

  $('.theme-item').on('click', function(e) {
    e.preventDefault();

    var themeName = $(this).attr('data-theme-name');
    var themeUrl = $(this).attr('data-theme-url');

    setThemeCookie(themeName);
    $(themeLink).attr('href', themeUrl);
    changeSelection(themeName);
  });

  function changeSelection(themeName) {
    $('.theme-item').parents('li.active').removeClass('active');
    $('.theme-item[data-theme-name=' +themeName + ']').parents('li').addClass('active');
  }

  function setThemeCookie(themeName) {
    var cookieProps = {
      "main-theme" : themeName,
      "path" : "/",
      "expires" : "31 Dec 9999 23:59:59 GMT"
    }

    var cookieString = "";
    for (var key in cookieProps) {
      if (cookieProps.hasOwnProperty(key)) {
        cookieString += key + "=" + cookieProps[key] + ";" ;
      }
    }

    document.cookie = cookieString;
  };
})(jQuery);
