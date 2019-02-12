// 入れ替え
function change() {
  var leftImgSrc = document.getElementById('img_left').src;
  document.getElementById('img_left').src = document.getElementById('img_right').src;
  document.getElementById('img_right').src = leftImgSrc;
}
