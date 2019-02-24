$(function() {
	$("#submit").click(function() {
		$.ajax({
			url: "http://192.168.33.10:4567/homework21",
			dataType: "json",
			data: {
				text1: $("#text1").val(),
				text2: $("#text2").val(),
				text3: $("#text3").val(),
				radio: $("#radio").val()
			},
			success: function(result) {
				$("#result").html("テキストボックス1つ目：" + result.text1 + "　テキストボックス2つ目：" + result.text2 + "　テキストボックス3つ目：" + result.text3 + "　ラジオボタン：" + result.radio);
			}
		});
	});
});