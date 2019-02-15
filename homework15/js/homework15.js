// var startX;
// var startY;
var clickCount;

// 初期化
function initialize() {
	// startX = 0;
	// startY = 0;
	clickCount = 0;
}

// マウスの座標取得
function getMousePosition(canvas, e) {
	var rect = canvas.getBoundingClientRect();
	return {
		x: e.clientX - rect.left,
		y: e.clientY - rect.top
	};
}

// マウス移動時のイベント
function mouseMove(context, canvas, e) {
	var mousePos = getMousePosition(canvas, e);

	if (clickCount === 1 || clickCount === 2) {

	}
}

// マウスクリック時のイベント
function mouseClick(context, canvas, e) {
	var mousePos = getMousePosition(canvas, e);
	clickCount++;

	switch(clickCount) {
		// クリック1回目
		case 1:
			// startX = mousePos.x;
			// startY = mousePos.y;
			// 最初の点
			context.beginPath();
			context.moveTo(mousePos.x, mousePos.y);
		break;
		
		// クリック2回目
		case 2:
			// startX = mousePos.x;
			// startY = mousePos.y;
			// 2番目の点
			context.lineTo(mousePos.x, mousePos.y);
			context.stroke();
		break;

		// クリック3回目
		case 3:
			// 3番目の点
			context.lineTo(mousePos.x, mousePos.y);
			context.closePath();

			// 枠線
			context.stroke();
			
			// 塗りつぶし
			context.fill();
		break;
		
		// クリック4回目
		case 4:
			// キャンバス全体をクリア
			context.clearRect(0, 0, canvas.width, canvas.height);
			// クリック回数を初期化
			clickCount = 0;
		break;

		// それ以外（何もしない）
		default:
		break;
	}
}

function canvas() {
	// 描画コンテキストの取得
	var canvas = document.getElementById("canvas");
	if (canvas.getContext) {
		initialize();
		var context = canvas.getContext("2d");
		// 枠線の色を指定
		context.strokeStyle = "#000";
		// 塗りつぶしの色を指定
		context.fillStyle = "#00F";
		// マウス移動時のイベントリスナー設定
		canvas.addEventListener("mousemove", function(e) {
			mouseMove(context, canvas, e)
		});
		// マウスクリック時のイベントリスナー設定
		canvas.addEventListener("click", function(e) {
			mouseClick(context, canvas, e)
		});
	}
}