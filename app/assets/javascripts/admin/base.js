document.addEventListener('turbolinks:load', function(){
  var $zipcode = $('.zipcode');

  $notice = $('.notice-container');
  window.setTimeout((function(){
    $notice.remove();
  }), 3500);

//   $zipcode.mask('99999-999', {
//     completed: function(){
//       var $that = $(this)
//       var value = $that.val();
//
//       var request = $.ajax({
//         type: 'GET',
//         url: '/api/zipcode?zipcode=' + value
//       });
//
//       request.done(function(res){
//         if(res.data) {
//           $('.neighborhood').val(res.data.neighborhood).trigger('keypress')
//           $('.street').val(res.data.street).trigger('keypress')
//           $('#local_address_attributes_city').val(res.data.city.name).trigger('keypress')
//           $('.city-id').val(res.data.city.id)
//           $('.number').trigger('keypress').focus()
//         }
//       });
//     }
//   });
})
