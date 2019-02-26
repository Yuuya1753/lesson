$(function() {
	$("#submit").click(function() {
		$.ajax({
			url: "http://192.168.33.10:4567/homework23",
			type: 'POST',
			dataType: "json",
			data: {
				text: $("#textarea").val()
			},
			success: function(result) {
				
				var data_array = [];
				Object.keys(result).forEach(function (key) {
					data_array.push({ label: key, y: result[key] });
				});
				var options = {
					title: {
						text: "word count result"
					},
					axisX: { labelAngle: -90 },
					data: [
						{
							type: "column",
							dataPoints: data_array
						}
					]
				};
				$("#result").CanvasJSChart(options);
			}
		});
	});
});