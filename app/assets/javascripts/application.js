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
$(document).ready(function(){
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
});

