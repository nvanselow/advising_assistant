$('document').ready(function(){
  var flashInfo = $('.flash').first();
  if(flashInfo.length) {
    var type = flashInfo.data('type');
    var message = flashInfo.data('message');
    Materialize.toast(message, 3000, 'alert ' + type);
  }
});
