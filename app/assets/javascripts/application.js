// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .

// http://picplz.com/user/kyanny/pic/105sg/download/
// text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8

/*
function download(uid, last_pic_id){
  var data = {
    id: uid,
    include_pics: 1
  };
  if (last_pic_id) {
    data.last_pic_id = last_pic_id;
  }
  
  $.getJSON('http://api.picplz.com/api/v2/user.json?callback=?', data, function(res){
    $.each(res.value.users[0].pics, function(index, pic){
      var download_url = 'http://picplz.com' + pic.url + 'download/';
      embed(download_url);
    });
    
    if (res.value.users[0].more_pics) {
      var last_pic_id = res.value.users[0].last_pic_id;
      download(uid, last_pic_id);
    } else {
      done();
    }
  });
}

function embed(url){
  $('<li>').append(
    $('<a>').attr({
      href: url,
      target: '_blank'
    }).text(url)
  ).appendTo('#pics ul');
}

function done(){
  $('#loading p').text('done!');
  $('#download').show();
}
  
$(function(){
  $('#download').click(function(){
    var pic_count = $('#pics a').length;
    Deferred.loop({begin:1, end:pic_count, step:10}, function(n, o){
      console.log(n);
      
      return o.last? n : Deferred.wait(5);
    });
//    alert($('#pics a').length);
//    $('#pics a').each(function(index, elem){
//      elem.click();
//    });
  });
  
  var uid = $('#uid').val();
  if (uid) {
    download(uid, null);
  }
});
*/