var startX;
var startY;
var clickCount;

// 初期化
function initialize() {
	startX = 0;
	startY = 0;
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

// マウスクリック時のイベント
function mouseClick(context, canvas, e) {
	var mousePos = getMousePosition(canvas, e);
	clickCount++;

	switch(clickCount) {
		// クリック1,3回目
		case 1:
		case 3:
			// 始点の座標を保存しておく
			startX = mousePos.x;
			startY = mousePos.y;
		break;
		
		// クリック2回目
		case 2:
			// 塗りつぶしの色を指定
			context.fillStyle = "#FF0";
			// パスを初期化
			context.beginPath();
			// 四角形の描画
			context.rect(startX, startY, mousePos.x - startX, mousePos.y - startY);
			context.fill();
		break;
		
		// クリック4回目
		case 4:
			// 塗りつぶしの色を指定（1回目とは別の色を指定）
			context.fillStyle = "#00F";
			// 重なった部分は描画しないように設定
			context.globalCompositeOperation = "xor";
			// パスを初期化
			context.beginPath();
			// 四角形の描画
			context.rect(startX, startY, mousePos.x - startX, mousePos.y - startY);
			context.fill();
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
		// マウスクリック時のイベントリスナー設定
		canvas.addEventListener("click", function(e) {
			mouseClick(context, canvas, e)
		});
	}
}