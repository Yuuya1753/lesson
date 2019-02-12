var firstImageObj;

// 画像を選択した時
function select(obj) {
  // 1回目の選択の場合
  if (firstImageObj === undefined) {
    firstImageObj = obj;
    obj.style.borderColor = "red";
  // 2回目の選択の場合
  } else {
    // 画像入れ替え
    var tmpSrc = obj.src;
    obj.src = firstImageObj.src;
    firstImageObj.src = tmpSrc;
    firstImageObj.style.borderColor = "black";
    obj.style.borderColor = "black";
    firstImageObj = undefined;
  }
}
