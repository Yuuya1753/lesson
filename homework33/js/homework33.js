$(function() {
	$(".box1").on("inview", function(e, isInView) {
		if(isInView) {
			$(this).addClass("lightSpeedIn");
		} else {
			$(this).removeClass("lightSpeedIn");
			$(this).css("opacity", 0);
		}
	});

	$(".box2").on("inview", function(e, isInView) {
		if(isInView) {
			$(this).addClass("rollIn");
		} else {
			$(this).removeClass("rollIn");
			$(this).css("opacity", 0);
		}
	});

	$(".box3").on("inview", function(e, isInView) {
		if(isInView) {
			$(this).addClass("fadeInRight");
		} else {
			$(this).removeClass("fadeInRight");
			$(this).css("opacity", 0);
		}
	});

	$(".box4").on("inview", function(e, isInView) {
		if(isInView) {
			$(this).addClass("flipInY");
		} else {
			$(this).removeClass("flipInY");
			// $(this).css("opacity", 0);
		}
	});

	$(".box5").on("inview", function(e, isInView) {
		if(isInView) {
			$(this).addClass("zoomInLeft");
		} else {
			$(this).removeClass("zoomInLeft");
			// $(this).css("opacity", 0);
		}
	});

	$(".box6").on("inview", function(e, isInView) {
		if(isInView) {
			$(this).addClass("bounceInRight");
		} else {
			$(this).removeClass("bounceInRight");
			// $(this).css("opacity", 0);
		}
	});

	$(".box7").on("inview", function(e, isInView) {
		if(isInView) {
			$(this).addClass("rotateInDownLeft");
		} else {
			$(this).removeClass("rotateInDownLeft");
			$(this).css("opacity", 0);
		}
	});

	$(".box8").on("inview", function(e, isInView) {
		if(isInView) {
			$(this).addClass("slideInLeft");
		} else {
			$(this).removeClass("slideInLeft");
			// $(this).css("opacity", 0);
		}
	});
});