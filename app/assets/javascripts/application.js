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
      arrows: false,
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

  $('#post_post_images_images').on('change', function (e) {

    if(e.target.files.length > 5){

      alert('一度に投稿できるのは五枚までです。');
      // 五枚以上の画像を選択していた場合、選択したファイルをリセット。
      $('#post_post_images_images').val = "";

      // 以前の画像のプレビューが残っていた場合は、
      // まだ画像選択できていると勘違いを誘発するため初期化。
      for( let i = 0; i < 5; i++) {
        $(`#preview_${i}`).attr('src', "");
      }

    }else{
      let reader = new Array(5);

      // 画像選択を二回した時、一回目より数が少なかったりすると画面上に残るので初期化
      for( let i = 0; i < 5; i++) {
        $(`#preview_${i}`).attr('src', "");
      }

      for(let i = 0; i < e.target.files.length; i++) {
        reader[i] = new FileReader();
        reader[i].onload = finisher(i,e);
        reader[i].readAsDataURL(e.target.files[i]);

        // onloadは別関数で準備しないとfor文内では使用できないので、関数を準備。
        function finisher(i,e){
          return function(e){
          $(`#preview_${i}`).attr('src', e.target.result);
          }
        }
      }
   }
});

  //無限読み込みInfiniteScroll
// 	$('.article-list').infinitescroll({	//無限読み込みをさせたい要素を囲う親のクラス名を指定
// 		navSelector  : ".navigation",//次のページを読み込むリンクを囲んでいるクラス名を指定
// 		nextSelector : ".navigation a",//次のページにリンクする要素を指定
// 		itemSelector : ".article-list li",//無限スクロールで表示をさせたい要素を指定
// 		maxPage : 5,///読み込む全体のページ数。入れないと連番でURLが読まれて404エラーが出る
// 		animate: true, //アニメーション処理を行う
// 			loading: {
// 			finishedMsg: "全ての記事が読み込まれました", //全ての要素が読み込まれた後の終了メッセージ
// 			msgText: "読み込み中", //ローディング中の表示テキスト
// 			img: 'svg/loading.svg', //ローディング中の画像を指定
// 		},
// 	});

	$('.article-list').hide().delay(100).fadeIn(900);//0.9秒かけてフェードイン

   //任意のタブにURLからリンクするための設定
  function GethashID (hashIDName){
  	if(hashIDName){
  		//タブ設定
  		$('.tab li').find('a').each(function() { //タブ内のaタグ全てを取得
  			var idName = $(this).attr('href'); //タブ内のaタグのリンク名（例）#lunchの値を取得
  			if(idName == hashIDName){ //リンク元の指定されたURLのハッシュタグ（例）http://example.com/#lunch←この#の値とタブ内のリンク名（例）#lunchが同じかをチェック
  				var parentElm = $(this).parent(); //タブ内のaタグの親要素（li）を取得
  				$('.tab li').removeClass("active"); //タブ内のliについているactiveクラスを取り除き
  				$(parentElm).addClass("active"); //リンク元の指定されたURLのハッシュタグとタブ内のリンク名が同じであれば、liにactiveクラスを追加
  				//表示させるエリア設定
  				$(".post-area").removeClass("is-active"); //もともとついているis-activeクラスを取り除き
  				$(hashIDName).addClass("is-active"); //表示させたいエリアのタブリンク名をクリックしたら、表示エリアにis-activeクラスを追加
  			}
  		});
  	}
  }

  //タブをクリックしたら
  $('.tab a').on('click', function() {
  	var idName = $(this).attr('href'); //タブ内のリンク名を取得
  	GethashID (idName);//設定したタブの読み込みと
  	return false;//aタグを無効にする
  });


  // 上記の動きをページが読み込まれたらすぐに動かす
  $(window).on('load', function () {
      $('.tab li:first-of-type').addClass("active"); //最初のliにactiveクラスを追加
      $('.post-area:first-of-type').addClass("is-active"); //最初の.areaにis-activeクラスを追加
  	var hashName = location.hash; //リンク元の指定されたURLのハッシュタグを取得
  	GethashID (hashName);//設定したタブの読み込み
  });

  $('.top-posts-slider').slick({
		autoplay: true,//自動的に動き出すか。初期値はfalse。
		infinite: true,//スライドをループさせるかどうか。初期値はtrue。
		slidesToShow: 3,//スライドを画面に3枚見せる
		slidesToScroll: 3,//1回のスクロールで3枚の写真を移動して見せる
		prevArrow: '<div class="slick-prev"></div>',//矢印部分PreviewのHTMLを変更
		nextArrow: '<div class="slick-next"></div>',//矢印部分NextのHTMLを変更
		dots: true,//下部ドットナビゲーションの表示
		responsive: [
			{
			breakpoint: 769,//モニターの横幅が769px以下の見せ方
			settings: {
				slidesToShow: 2,//スライドを画面に2枚見せる
				slidesToScroll: 2,//1回のスクロールで2枚の写真を移動して見せる
			}
		},
		{
			breakpoint: 426,//モニターの横幅が426px以下の見せ方
			settings: {
				slidesToShow: 1,//スライドを画面に1枚見せる
				slidesToScroll: 1,//1回のスクロールで1枚の写真を移動して見せる
			}
		}
	]
	});
	
	$('.post-show-images-slick').slick({
		autoplay: true,//自動的に動き出すか。初期値はfalse。
		autoplaySpeed: 3000,//次のスライドに切り替わる待ち時間
		speed:1000,//スライドの動きのスピード。初期値は300。
		infinite: true,//スライドをループさせるかどうか。初期値はtrue。
		slidesToShow: 1,//スライドを画面に3枚見せる
		slidesToScroll: 1,//1回のスクロールで3枚の写真を移動して見せる
		arrows: true,//左右の矢印あり
		dots: true,//下部ドットナビゲーションの表示
        pauseOnFocus: false,//フォーカスで一時停止を無効
        pauseOnHover: false,//マウスホバーで一時停止を無効
        pauseOnDotsHover: false,//ドットナビゲーションをマウスホバーで一時停止を無効
    });

  //テキストのカウントアップ+バーの設定
  var bar = new ProgressBar.Line(splash_text, {//id名を指定
  	easing: 'easeInOut',//アニメーション効果linear、easeIn、easeOut、easeInOutが指定可能
  	duration: 1000,//時間指定(1000＝1秒)
  	strokeWidth: 0.2,//進捗ゲージの太さ
  	color: '#555',//進捗ゲージのカラー
  	trailWidth: 0.2,//ゲージベースの線の太さ
  	trailColor: '#bbb',//ゲージベースの線のカラー
  	text: {//テキストの形状を直接指定
  		style: {//天地中央に配置
  			position: 'absolute',
  			left: '50%',
  			top: '50%',
  			padding: '0',
  			margin: '-30px 0 0 0',//バーより上に配置
  			transform:'translate(-50%,-50%)',
  			'font-size':'1rem',
  			color: '#fff',
  		},
  		autoStyleContainer: false //自動付与のスタイルを切る
  	},
  	step: function(state, bar) {
  		bar.setText(Math.round(bar.value() * 100) + ' %'); //テキストの数値
  	}
  });

  //アニメーションスタート
  bar.animate(1.0, function () {//バーを描画する割合を指定します 1.0 なら100%まで描画します
  	$("#splash").delay(500).fadeOut(800);//アニメーションが終わったら#splashエリアをフェードアウト
  });


});