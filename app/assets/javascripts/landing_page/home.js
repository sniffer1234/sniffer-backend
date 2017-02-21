$(document).ready(function(){

	if ($('#navigation').hasClass('scrollspy')) {
		$('#navigation_affix').addClass('scrollspy');
	}

	var waypoint = new Waypoint({
	  element: document.getElementById('navigation'),
	  handler: function(direction) {
	    $('#navigation_affix').removeClass('show');
	  },
	  offset: -100
	})

	var waypoint = new Waypoint({
	  element: document.getElementById('navigation'),
	  handler: function(direction) {
	    $('#navigation_affix').addClass('show');
	  },
	  offset: -101
	})

	$('.testimonials-slider').slick({
    arrows: false,
    dots: true,
    speed: 300,
    autoplay: true,
    autoplaySpeed: 5000,
    draggable: false,
    responsive: [{
      breakpoint: 768,
      settings: {
        draggable: true
      }
    }]
  });

  // Screenshots slider
  $('.carousel-slider.screenshots-slider').slick({
    arrows: false,
    dots: true,
    speed: 400,
    autoplay: true,
    autoplaySpeed: 5000,
    draggable: false,
    responsive: [{
      breakpoint: 768,
      settings: {
        draggable: true
      }
    }]
  });

  // General slider
  $('.carousel-slider.general-slider').slick({
    dots: true,
    speed: 300,
    adaptiveHeight: true,
    draggable: false,
    responsive: [{
      breakpoint: 768,
      settings: {
        draggable: true
      }
    }]
  });
})
