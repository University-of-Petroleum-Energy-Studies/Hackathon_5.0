function validateEmail(emailField){
        var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;

        if (reg.test(emailField) == false) 
        {
           return false;
        }

        return true;

}


Template.reg.rendered = function(){

   
};



Template.reg.events({
	// 'click #submitlogin'() {
	// },
	'click #letslogin'() {
		FlowRouter.go("/");
	},
	
	
    'click #submitregister'() {
		
		name = document.getElementById("name").value;
		email = document.getElementById("email").value;
		pass1 = document.getElementById("pass1").value;
		pass2 = document.getElementById("pass2").value;
		
		name = name.trim();
		email = email.trim();
		pass1 = pass1.trim();
		pass2 = pass2.trim();
		
		if(name.length < 1)
		{
			  swal("Error", "Name is Empty", "warning");
		}
		else if(email.length < 1)
		{
			 swal("Error", "Email is Empty", "warning");
		}
		else if(pass1.length < 1)
		{
			 swal("Error", "Password is Empty", "warning");
		}
		else if(pass2.length < 1)
		{
			 swal("Error", "Re-Enter password is Empty", "warning");
		}
		else if(pass1 != pass2)
		{
			 swal("Error", "Password & Re-Enter password does not match", "warning");
		}
		else if(validateEmail(email) == false)
		{
			 swal("Error", "Email is invalid", "warning");
		}
		else
		{
			//meteor call starts here
			Meteor.call('registeruser',name, email, pass1, (err, res) => {
             if (err) {
               swal("Error", "Something went wrong, Please try again", "warning");
              } else {
             
			 if(res == 1)
			 {
				 swal("Success", "User added successfully", "success");
				 FlowRouter.go("/");
			 }
			  
              }
            });
			//meteor call ends here
		}
 
	  
	  
	  
  
    },
  });