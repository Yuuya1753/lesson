// サイズ変更
function sizeChange() {
  var images = document.getElementsByClassName('image');

  for (var i = 0; i < images.length; i++) {
    images[i].height = images[i].naturalHeight / 2;
    images[i].width = images[i].naturalWidth / 2;
  }
}
