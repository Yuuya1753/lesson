$(function() {
	$("#result").ready(function() {
		$.ajax({
			url: "http://192.168.33.10:4567/homework31/get",
			type: 'GET',
			dataType: "json",
			success: function (result) {
				Object.keys(result).forEach(function(key) {
					var path = result[key].replace("public", "..");
					$("#result").append("<img src=\"" + path + "\">");
				});
			}
		});
	});
});
