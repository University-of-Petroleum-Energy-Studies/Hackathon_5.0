Template.letslogin.rendered = function(){

   
};



Template.letslogin.events({
	// 'click #submitlogin'() {
	// },
	'click #forgetpass'() {
		FlowRouter.go("/forgot");
	},
	'click #reg'() {
		FlowRouter.go("/reg");
	},
	
    'click #submitlogin'() {
      // Prevent default browser form submit
      //event.preventDefault();
	  //alert("you submitted the form");
	  
	  emailis = document.getElementById("emailis").value;
	  passwordis = document.getElementById("passwordis").value;
	  
	  emailis = emailis.trim();
	  passwordis = passwordis.trim();
	  
	  if(emailis.length < 1)
	  {
		  swal("Error", "Email address is empty, please try again!", "warning");
	  }
	  else if(passwordis.length < 1)
	  {
		  swal("Error", "Password is empty, please try again!", "warning");
	  }
	  else
	  {
		 //meteor call starts here
			Meteor.call('checklogin',emailis, passwordis, (err, res) => {
             if (err) {
               swal("Error", "Something went wrong, Please try again", "warning");
              } 
			 else {
             
			 if(res == 0)
			 {
				swal("Error", "Invalid Credentials", "warning");
				    document.getElementById("emailis").value = 0;
	                document.getElementById("passwordis").value = 0;
			 }
			 else
			 {
				 // swal("Success", "Logged in successfully", "success");
				 Session.setAuth("useremail",emailis);
				 Session.setAuth("userName",res);
				 console.log("username on client");
				 console.log(Session.get("userName"));
				 
				 FlowRouter.go("/quest");
				  
			 }
			
			  
              }
            });
			//meteor call ends here
		 
		 
	  }
	  
	  
  
    },
  });