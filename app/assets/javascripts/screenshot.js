// 概要：users/:idページのtwitterシェアボタン押下時に画面のキャプチャを取る

// キャプチャを取るページのURL
var url = location.href;

// headlessブラウザを作る(webページ用のインスタンス作成)
// コマンドライン引数をsystemとして受け取る（from user#take_screenshot）
debugger;
var page = require('webpage').create();
var system = require('system');


// キャプチャの取得範囲を決定する箇所だが、今は使わない
// デザインが決定次第、数値調整のうえ使用
// page.viewportSize = { width: 1200, height: 600 };
// page.clipRect = {
//   top: 0,
//   left: 0,
//   width: 1200,
//   height: 600
// };

// コマンドライン引数1個目：system.args[1]
// コマンドライン引数2個目：キャプチャ取得サイトURL
page.open(system.args[1], function (status) {
  console.log('Status: ' + status);
  page.render(system.args[2]);
  phantom.exit();
});