// borrowed from http://engineeredweb.com/blog/09/12/preloading-images-jquery-and-javascript
(function($) {
  var cache = [];
  // Arguments are image paths relative to the current page.
  $.preLoadImages = function() {
    var args_len = arguments.length;
    for (var i = args_len; i--;) {
      var cacheImage = document.createElement('img');
      cacheImage.src = arguments[i];
      cache.push(cacheImage);
    }
  }
})(jQuery)



// future-proof... one day we'll have more options
var options = [1,2];
var current = 0;
$(document).ready(function(){
  $.preLoadImages('/1h.jpg', '/2h.jpg');
});

function deselectExcept(keep){
  $.each(options, function() {
    if (this != keep){
      $('#option_' + this).hide();
      $('#option_button_' + this).css('background-image', 'url(/' + this + 'n.jpg)').css('border', '0px').css('margin-left', '0px');
    }
  });
}

function showOpt(number){
  if (number != current){
    current = number;
    deselectExcept(number);
    $('#option_' + number).show();
    $('#option_button_' + number).css('background-image', 'url(/' + number + 'h.jpg)').css('border-left', '2px solid #37921d').css('margin-left', '-2px');
  }
}

