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

function selectOpt(keep){
  $.each(options, function() {
    var el = $('#option_button_' + this);
    if (this != keep){
      var normalImg = NormalImgOf(el.attr("src"));
      el.attr("src", normalImg);
      $('#option_' + this).hide();
    }
    else{
      var hoverImg = HoverImgOf($(el).attr("src"));
      $(el).attr("src", hoverImg);
      $('#option_' + this).show();
    }
  });
}

function showOpt(number){
  if (number != current){
    current = number;
    selectOpt(number);
  }
}

//borrowed from http://www.yart.com.au/Resources/jQuery/jQuery---Auto-replace-image-on-hover.aspx until I work on another version

$(document).ready(function(){
   // Change the image of hoverable images
   $(".imgHoverable").hover( function() {
       var hoverImg = HoverImgOf($(this).attr("src"));
       $(this).attr("src", hoverImg);
     }, function() {
       if (parseInt(this.id.split('option_button_')[1]) != current){
         var normalImg = NormalImgOf($(this).attr("src"));
         $(this).attr("src", normalImg);
       }
     }
   );
});

function HoverImgOf(filename){
   var re = new RegExp("(.+)n\\.(gif|png|jpg)", "g");
   return filename.replace(re, "$1h.$2");
}
function NormalImgOf(filename){
   var re = new RegExp("(.+)h\\.(gif|png|jpg)", "g");
   return filename.replace(re, "$1n.$2");
}

