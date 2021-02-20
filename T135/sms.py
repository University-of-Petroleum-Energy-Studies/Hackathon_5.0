# import required module 
import requests 
import json
# mention url 
# mention url 
url = "https://www.fast2sms.com/dev/bulk"


# create a dictionary 
my_data = { 
	# Your default Sender ID 
	'sender_id': 'FSTSMS', 
	
	# Put your message here! 
	'message': 'This is a test message', 
	
	'language': 'english', 
	'route': 'p', 
	
	# You can send sms to multiple numbers 
	# separated by comma. 
	'numbers': '8081495049,7983500455,6205492184'	
} 

# create a dictionary 
headers = { 
	'authorization': 'yRcBqrK2xbkOn1lH63pGUJPQwSdf9T0u5ChNeAaXIv7soDV8itYgJcnOZEoM3UqPH1V94hQGuijxyDRe', 
	'Content-Type': "application/x-www-form-urlencoded", 
	'Cache-Control': "no-cache"
}
# make a post request 
response = requests.request("POST", 
							url, 
							data = my_data, 
							headers = headers) 
# load json data from source 
returned_msg = json.loads(response.text) 

# print the send message 
print(returned_msg['message'])
