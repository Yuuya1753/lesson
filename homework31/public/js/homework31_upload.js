$(function() {
	$("#submit").click(function() {
		var fd = new FormData($("#form_data").get(0));
		$.ajax({
			url: "http://192.168.33.10:4567/homework31/submit",
			type: 'POST',
			processData: false,
			contentType: false,
			dataType: "text",
			data: fd,
			success: function(result) {
				$("#result").html(result + "をアップロードしました。");
			}
		});
	});
});
