window.addEventListener("load", function() {
  var imageInputs = document.querySelectorAll('[type=file]');

  for (var i=0, len=imageInputs.length; i<len; ++i) {
    var imageInput = imageInputs[i];

    imageInput.addEventListener('change',function(ev) {
      var reader = new FileReader();
      var target = ev.target;
      var file = target.files[0];
      reader.readAsDataURL(file);

      reader.addEventListener('load', function(){
        var image_tag = target.nextElementSibling
        image_tag.src = reader.result;
      });
    });
  };
});
