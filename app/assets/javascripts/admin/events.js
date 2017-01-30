document.addEventListener('turbolinks:load', function(){
  var $to = $('.event_ends_at');

  // Disable 'to' field when clicks on the 'Sem hora para terminar' checkbox
  $('#event-no-end').on('click', function(){
    $to.toggleClass('hide')
  });
});
