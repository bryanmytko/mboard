$(document).ready(function(){

  var faye = new Faye.Client('http://fidelio-faye.herokuapp.com:80/faye');

  Faye.Transport.WebSocket.isUsable = function(_,c) { c(false) }
	//	faye.setHeader('Access-Control-Allow-Origin', '*');
	//	faye.connect();
  //  faye.disable('websocket');

  faye.subscribe("/messages/new", function(data){
      eval(data);
      scroll_current();
   });

	faye.callback(function(){
		console.log('callback');
		scroll_current();
	});
	
	faye.errback(function(error) {
	});

  function scroll_current(){
	
	  var chat_box = $('#chat_box');
		var chat_list = $('#chat_list');
		
		$('#chat_box').animate({ 
		   scrollTop: chat_list.height() - chat_box.height() }, 0
		);
		
	}
	
	scroll_current();


});
