var all_result = {};

$(function() {
	$("#submit").click(function() {
		$.ajax({
			url: "http://192.168.33.10:4567/homework25/submit",
			type: 'POST',
			dataType: "json",
			data: {
				text: $("#textarea").val()
			},
			success: function(result) {
				all_result = result;
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

	$("#add").click(function() {
		$.ajax({
			url: "http://192.168.33.10:4567/homework25/add",
			type: 'POST',
			dataType: "json",
			data: {
				text: $("#textarea").val(),
				all_data: all_result
			},
			success: function(result) {
				all_result = result;
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