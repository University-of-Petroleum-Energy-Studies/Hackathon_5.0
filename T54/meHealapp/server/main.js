Meteor.methods({
  'registeruser'(name, email, pass1) {
   userlogin.insert({"name":name,"email":email,"password":pass1})
   return 1;
  },
  
  'checklogin'(emailis,passwordis) {
   totalval = userlogin.find({"email":emailis,"password":passwordis}).count();
   
   if(totalval == 0)
   {
	   return 0;
   }
   else
   {
	   thisval = userlogin.find({"email":emailis}).fetch();
	   thisname = thisval[0].name;
	   console.log(thisname);
	   return thisname;
   }
 
  }
  
});