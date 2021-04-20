// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery

//= require jquery3
//= require popper
//= require bootstrap-sprockets

//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .


$(document).on("turbolinks:load",function(){
  $(".openbtn").click(function() { //ボタンをクリック
    $(this).toggleClass('active'); //classを付与↓
    $("#g-nav").toggleClass('panelactive');
    $(".circle-bg").toggleClass('circleactive');
  });
  $("#g-nav a").click(function() { //ナビゲーションリンクをクリック
    $(".openbtn").removeClass('active'); //classを付与↓
    $("#g-nav").removeClass('panelactive');
    $(".circle-bg").removeClass('circleactive');
  });
  //スクロールした際の動きを関数でまとめる
function PageTopAnime() {
  var scroll = $(window).scrollTop();
  if (scroll >= 100){//上から100pxスクロールしたら
    $('#page-top').removeClass('DownMove');//#page-topについているDownMoveというクラス名を除く
    $('#page-top').addClass('UpMove');//#page-topについているUpMoveというクラス名を付与
  }else{
    if($('#page-top').hasClass('UpMove')){//すでに#page-topにUpMoveというクラス名がついていたら
      $('#page-top').removeClass('UpMove');//UpMoveというクラス名を除き
      $('#page-top').addClass('DownMove');//DownMoveというクラス名を#page-topに付与
    }
  }
}

// 画面をスクロールをしたら動かしたい場合の記述
$(window).scroll(function () {
  PageTopAnime();/* スクロールした際の動きの関数を呼ぶ*/
});

// ページが読み込まれたらすぐに動かしたい場合の記述
$(window).on('load', function () {
  PageTopAnime();/* スクロールした際の動きの関数を呼ぶ*/
});


// #page-topをクリックした際の設定
$('#page-top').click(function () {
  var scroll = $(window).scrollTop(); //スクロール値を取得
  if(scroll > 0){
    $(this).addClass('floatAnime');//クリックしたらfloatAnimeというクラス名が付与
        $('body,html').animate({
            scrollTop: 0
        }, 1000,function(){//スクロールの速さ。数字が大きくなるほど遅くなる
            $('#page-top').removeClass('floatAnime');//上までスクロールしたらfloatAnimeというクラス名を除く
        });
  }
    return false;//リンク自体の無効化
  });

  $(function() {
    $('.top-visual-slick').slick({
      dots: true,
      autoplay: true,
      autoplaySpeed: 3000,
      speed: 400,
      fade: true,
    });
  });
  $('.comment-form-btn').on('click', function () {
    // クリックで次にあるコンテンツを開閉
    $(this).next().slideToggle(200);
    // 矢印の向きを変更
    $(this).toggleClass('open', 200);
  });
  $('.about-image').on('click', function () {
    // クリックで次にあるコンテンツを開閉
    $(this).next().slideToggle(200);
    // 矢印の向きを変更
    $(this).toggleClass('open', 200);
  });
});