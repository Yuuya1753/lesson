var all_result = {};
var data_array = [];

function drawChart(graph_type) {
	var options = {};
	switch (graph_type) {
		case "column":
			options = {
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
			break;

		case "pie":
			options = {
				title: {
					text: "word count result"
				},
				data: [
					{
						type: "pie",
						startAngle: -90,
						dataPoints: data_array
					}
				]
			};
			break;

		default:
			break;
	}
	$("#result").CanvasJSChart(options);
}

$(function() {
	$("#submit").click(function() {
		$.ajax({
			url: "http://192.168.33.10:4567/homework26/submit",
			type: 'POST',
			dataType: "json",
			data: {
				text: $("#textarea").val()
			},
			success: function(result) {
				all_result = result;
				data_array = [];
				Object.keys(result).forEach(function (key) {
					data_array.push({ label: key, y: result[key] });
				});
				drawChart($("option:selected").val());
			}
		});
	});

	$("#add").click(function() {
		$.ajax({
			url: "http://192.168.33.10:4567/homework26/add",
			type: 'POST',
			dataType: "json",
			data: {
				text: $("#textarea").val(),
				all_data: all_result
			},
			success: function(result) {
				all_result = result;
				data_array = [];
				Object.keys(result).forEach(function (key) {
					data_array.push({ label: key, y: result[key] });
				});
				drawChart($("option:selected").val());
			}
		});
	});

	$("#select_graph").change(function() {
		drawChart($("option:selected").val());
	});
});
