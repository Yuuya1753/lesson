var firstPos;
var secondPos;
var clickCount;

// 初期化
function initialize() {
	firstPos = { x: 0, y: 0 };
	secondPos = { x: 0, y: 0 };
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

	switch(clickCount) {
		// 1回目のクリック後
		case 1:
			// キャンバス全体をクリア、パスの初期化をしつつ、
			// 1回目のクリックの座標から現在のマウスの座標へ線を引く
			context.clearRect(0, 0, canvas.width, canvas.height);
			context.beginPath();
			context.moveTo(firstPos.x, firstPos.y);
			context.lineTo(mousePos.x, mousePos.y);
			context.stroke();
		break;

		// 2回目のクリック後
		case 2:
			// キャンバス全体をクリア、パスの初期化、
			// 1回目のクリックの座標から2回目のクリックの座標へと線を引きつつ、
			// 2回目のクリックの座標から現在のマウスの座標へ線を引く
			context.clearRect(0, 0, canvas.width, canvas.height);
			context.beginPath();
			context.moveTo(firstPos.x, firstPos.y);
			context.lineTo(secondPos.x, secondPos.y);
			context.lineTo(mousePos.x, mousePos.y);
			context.stroke();
		break;

		// それ以外（何もしない）
		default:
		break;
	}
}

// マウスクリック時のイベント
function mouseClick(context, canvas, e) {
	var mousePos = getMousePosition(canvas, e);
	clickCount++;

	switch(clickCount) {
		// クリック1回目
		case 1:
			// 1回目のクリックした座標を保存
			firstPos = mousePos;
		break;
		
		// クリック2回目
		case 2:
			// 2回目のクリックした座標を保存
			secondPos = mousePos;
		break;

		// クリック3回目
		case 3:
			// 3回目のクリックした座標へ線を引く
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
			// 初期化
			initialize();
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