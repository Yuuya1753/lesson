function wordCounter(text) {
	var words = text.replace(/\./g, "").toLowerCase().split(/[ \(\)\[\]\n]/);
	var word_count = {};
	var word_count_array = [];

	words.forEach(function(word) {
		if(word === "") {
			return;
		}
		if(word_count[word]) {
			word_count[word]++;
		} else {
			word_count[word] = 1;
		}
	});

	var keys = Object.keys(word_count);
	keys.forEach(function(key) {
		word_count_array.push([key, word_count[key]]);
	});

	return wordSort(word_count_array);
}

function wordSort(count) {
	count.sort(function(a, b) {
		if(a[1] > b[1]) {
			return -1;
		} else if (a[1] < b[1]) {
			return 1;
		} else if(a[0] > b[0]) {
			return 1;
		} else if(a[0] < b[0]) {
			return -1;
		} else {
			return 0;
		}
	});
	return count;
}

$(function() {
	$("#submit").click(function() {
		var text = $("#textarea").val();
		var count = wordCounter(text);
		var data_array = [];
		count.forEach(function(value) {
			data_array.push({label: value[0], y: value[1]});
		});
		var options = {
			title: {
				text: "word count result"
			},
			axisX: { labelAngle: -90},
			data: [
				{
					type: "column",
					dataPoints: data_array
				}
			]
		};
		$("#result").CanvasJSChart(options);
	});
});