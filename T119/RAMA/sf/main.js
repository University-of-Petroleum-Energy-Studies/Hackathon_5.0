


$(window).load(function() {
	ajaxRequest();


        function ajaxRequest(){ 
        /*    
        	$.ajax(
	   	{
	   		xhrFields: {
        withCredentials: true
    },
	   "type": "POST",
      	"url": "http://localhost:8080/gateway.watsonplatform.net/assistant/api/v1/workspaces/dca4bc2d-d659-45dd-ad24-736887aac411/message?version=2018-02-16",
        "username": "2dcc58ff-9c91-470b-827c-9dcdc8e8f618",
        "password": "3FfZMzXS41eb",
        "data": JSON.stringify({"input" :{"text ": "hello"}}),
        ContentType:"application/x-www-form-urlencoded; charset=UTF-8",
        xhrFields: {
      // The 'xhrFields' property sets additional fields on the XMLHttpRequest
      // This can be used to set the 'withCredentials' property
      // Set the value to 'true' to pass cookies to the server
      // If this is enabled, your server must respond with the header
      // 'Access-Control-Allow-Credentials: true'
      // Remember that IE <= 9 does not support the 'withCredentials' property
      withCredentials: false
    },
        //headers: {Access-Control-Allow-Origin:*},
        datatype:"JSON",
        crossDomain: true,
        //headers:{
        	//"Authorization": "Bearer" +
        //}
        //data: JSON.stringify
        success: function(data){
        	
        	console.log("successful");	
        	},
        	error: function(err){
        		console.log(err);
        	}
	});
    }

});


	/*axios.get('https://gateway.watsonplatform.net/assistant/api/v1/workspaces/dca4bc2d-d659-45dd-ad24-736887aac411/hello?version=2017-10-17' )
  .then(function(response){
    console.log(response.data); // ex.: { user: 'Your User'}
    console.log(response.status); // ex.: 200
  });  */

	/*function ajaxRequest(){
		axios.get('https://api.github.com/users/codeheaven-io');
            var username = "sarpaning Phelimon"
		axios.get('https://api.github.com/users/' + username)
  .then(function(response){
    console.log(response.data); // ex.: { user: 'Your User'}
    console.log(response.status); // ex.: 200
  });  */
         
        // var burl =  "https://api.infermedica.com/v2/parse";

		$.ajax({


			url : "https://api.infermedica.com/v2/parse",
 type: "POST" ,
 headers :{ "Content-Type": "application/json",
 	"App-Id": "1b4dd70a","App-Key": "01a1ad52bd0ca896dd349f1a10b3cd0d" }
  ,
   
   data: JSON.stringify({"text": "headache, running nose and upset stomach"}),
   success: function(data){
   	console.log(data);
   },
   error:function(err){
   	console.log(err);
   }
		});
	  
	   }

});