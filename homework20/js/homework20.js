$(function() {
	$("#submit").click(function() {
		$.ajax({
			url: "http://192.168.33.10:4567/homework20",
			data: $("#text").val(),
			success: function(result) {
				$("#result").html(result);
			}
		});
	});
});