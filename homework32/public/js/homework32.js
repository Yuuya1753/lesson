$(function() {
	$("#notice").hover(function() {
		// over
		$("#showed_notice").show("blind", 1000);
	}, function () {
		// out
	});

	$("#showed_notice").hover(function() {
		// over
	}, function() {
		// out
			$("#showed_notice").hide("blind", 1000);
	});

	$("#trans_text").dblclick(function() {
		$("#trans_text").val("");
	});

	$("#trans").click(function() {
		var url = "";
		switch($("input[name=site]:checked").val()) {
			case "alc":
				url = "http://192.168.33.10:4567/homework32/alc";
			break;
		}
		$.ajax({
			type: "POST",
			dataType: "json",
			url: url,
			data: { words: $("#trans_text").val() },
			success: function(result) {
				Object.keys(result).forEach(function(key) {
					$("#result_parent").append(result[key]);
				});
			}
		});
	});

});