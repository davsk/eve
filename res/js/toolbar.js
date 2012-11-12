$(function() {

	$("#console-menu a").each(function() {
		var s = $(this).attr("href").split("/")[1];
		if (window.location.pathname.indexOf(s) == 1) {
			$(this).parent().addClass("active");
		}
	});

});
