$(function() {

	$(".sidebar-nav a").each(function() {
		var s = $(this).attr("href");
		if (window.location.pathname == s) {
			$(this).parent().addClass("active");
		}
	});

	$("#select-api-key").on("change", function() {
		window.location = window.location;
	});

});
