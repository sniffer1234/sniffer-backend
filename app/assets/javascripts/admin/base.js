document.addEventListener('turbolinks:load', function(){
  $('#starts-at-picker').datetimepicker();
  $('#ends-at-picker').datetimepicker();

  $('[data-mask]').each(function(key, el){
    var $el = $(el)
    $el.mask($el.data('mask'))
  });

  $notice = $('.notice-container');
  window.setTimeout((function(){
    $notice.remove();
  }), 3500);

  var $zipcode = $('.zipcode');
  $zipcode.mask('99999-999', {
    completed: function(){
      var $that = $(this)
      var value = $that.val();

      var request = $.ajax({
        type: 'GET',
        url: '/api/zipcode?zipcode=' + value
      });

      request.done(function(res){
        if(res.data) {
          $('.neighborhood').val(res.data.neighborhood).trigger('keypress')
          $('.street').val(res.data.street).trigger('keypress')
          $('#local_address_attributes_city').val(res.data.city.name).trigger('keypress')
          $('.city-id').val(res.data.city.id)
          $('.number').trigger('keypress').focus()
        }
      });
    }
  });
})
