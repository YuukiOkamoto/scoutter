// コマンドライン引数をsystemとして受け取る（from user#take_screenshot）
var page = require('webpage').create();
var system = require('system');


//画面サイズ横幅の取得
var size = window.parent.screen.width;

// スマホ用の画面サイズとPC用の画面サイズ設定し、スクショする際の画面幅で使い分け

//PC用
// page.viewportSize = { width: 1200, height: 600 };
// if(size >= 800){
//   page.clipRect = {
//     top: 0,
//     left: 0,
//     width: 1200,
//     height: 600
//   };
// }

//スマホ用
// page.viewportSize = { width: 1200, height: 600 };
// if(size < 800){
//   page.clipRect = {
//     top: 0,
//     left: 0,
//     width: 1200,
//     height: 600
//   };
// }

var url = system.args[1] + '?access=phantomjs'

// system.args[1]：取得対象URL(戦闘力結果表示画面)
// system.args[2]：画像ファイル名
page.open(url, function (status) {
  console.log('Status: ' + status);
  if (status == "success") {
    page.render(system.args[2]);
  }
  phantom.exit();
});