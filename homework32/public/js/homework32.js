var disp_num = 0;
var before_div_id = "";

$(function() {
	$(document).keydown(function(e) {
		// ESCキー押下時
		if (e.keyCode === 27) {
			$("#result_parent").empty();
			disp_num = 0;
		}
	});

	$("#trans_text").ready(function() {
		if (localStorage.getItem("trans_text") !== null) {
			$("#trans_text").val(localStorage.getItem("trans_text"));
		}
	});
	
	$("#clear").click(function() {
		if (confirm("保存された単語を削除しますか？")) {
			if (localStorage.getItem("trans_text") !== null) {
				localStorage.removeItem("trans_text");
			}
		}
	});

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
	
	$("#result_parent").on("click", ".div_close", function() {
		$("#" + $(this).parent().get(0).id).remove();
	});

	$("#trans").click(function() {
		var text = $("#trans_text").val();
		if ($.trim(text) !== "") {
			localStorage.setItem("trans_text", text);
			var url = "";
			var site = $("input[name=site]:checked").val();
			var site_japanese = $("input[name=site]:checked").parent().text();
			switch(site) {
				case "alc":
					url = "http://192.168.33.10:4567/homework32/alc";
				break;

				case "sanseido":
					url = "http://192.168.33.10:4567/homework32/sanseido";
				break;

				case "nifty":
					url = "http://192.168.33.10:4567/homework32/nifty";
				break;
			}
			$.ajax({
				type: "POST",
				dataType: "json",
				url: url,
				data: { words: text },
				success: function(result) {
					Object.keys(result).forEach(function(key) {
						var div_id = "disp_" + disp_num;
						if (div_id === "disp_0") {
							$("#result_parent").append("<div id='" + div_id + "'></div>");
						} else {
							$("#" + before_div_id).before("<div id='" + div_id + "'></div>");
						}
						$("#" + div_id).append("<br>");
						$("#" + div_id).append("<span class='trans_key'>" + key + "</span>");
						$("#" + div_id).append("&emsp;");
						$("#" + div_id).append("<span class='trans_site_" + site + "'>&ensp;" + site_japanese + "&ensp;</span>");
						$("#" + div_id).append("&ensp;");
						$("#" + div_id).append("<input type='button' class='div_close' value='Close'>");
						$("#" + div_id).append("<hr>");
						$("#" + div_id).append(result[key]);
						disp_num++;
						before_div_id = div_id;
					});
				}
			});
		}
	});
});