$(document).ready(function(){

	$('#pb').click(function(){
		$.ajax({
		  type: "POST",
		  url: "/save_post",
		  data: $('#postarea').val(),
		  success: function(data){
		  	console.log("were in success");
		  	console.log(data);
		  },
		  error: function(data){
		  	console.log("we are in error");
		  	console.log(data);
		  }
		});	
	});
});	
