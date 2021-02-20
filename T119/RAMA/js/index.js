var $messages = $('.messages-content'),
	d, h, m,
	i = 0;
var ipad = '10.0.0.3';
var port = '8001';
var websocket;
var state = 0;
var cries_for_server = 0;
var lastURI;
var msg;
var msg_stack = [];
var inferm;
var symptoms_stack = [];
var myChoice;
var count = 0;
var main;
var save = [];
var fake;

/*{
	"evidence":
["id": code, "choice_id":choice,"initial":true]
};
*/
var age;
var sex;
var choice;
var id;
const messages = {
	"welcome": "Welcome to RAMA, your one stop AI diagnosis for wellbeing.",
	"name": "What is your name?",
	"age": "Please tell your age?",
	"gender": "What do you identify as(male/female/others)?",
	"feeling": "On a scale of 1 to 10 How are you feeling today?",
	"well": "It's good to know.",
	"not_well": "What's wrong with you?",
	"result": "error500, Server offline",
}
const userData = {
	name: '',
	age: '',
	gender: '',
	feeling: '',
}
const msgsKeys = Object.keys(messages);
var msgStep = '';
var inTransit = false;
$(window).load(function () {

	trueMessage(messages, "welcome");
	setTimeout(() => {
		trueMessage(messages, "name");
	}, 2000)
	//$.getScript('js/payment.js', function(){
	//console.log("got here");
	//if (username == null){
	//window.open("http://localhost:8080/medibot/index.html","_self");
	//}
	//});

	//var   start = ' Welcome to RAMA, your one stop AI diagnosis for wellbeing.';
	//trueMessage(start);


	//setTimeout(function(){
	//infermedicaCall(sickQuest);

	//},1000);

	/*var seekAge = "Could you tell us your age?";
	setTimeout(function(){
		trueMessage(seekAge);
	},1000);
	
	
	
     var begin = "Could you please tell us your sex?";
     /*do{
     	setTimeout(function() {
		trueMessage(begin);
		}, 1000);
     }*/



	//sex = 

	$messages.mCustomScrollbar();
	//var sickQuest = "What symptoms are you having?";
	/*setTimeout(function() {
         fakeMessage()}, 100);*/

	//init_websocket();
	// set focus to input area
	// startMessages()
	$('.message-input').focus();
});

async function startMessages() {
	setTimeout(() => {
		trueMessage(messages.age)
	}, 1000)
	await listen();
	setTimeout(() => {
		trueMessage(messages.gender)
	}, 1000)
	await listen();
	setTimeout(() => {
		trueMessage(messages.feeling)
	}, 1000)
	await listen();
}
const listen = new Promise((resolve, reject) => {

})

function infermedicaCall(call) {
	trueMessage(call);
	var ess = $('.message-input').val();
	console.log(msg);

	var final = $('.message-input').serialize();
	console.log(final);
	var hello = "text"
	var finish = hello + ":" + msg;
	console.log(finish);
	$.ajax({


		url: "https://api.infermedica.com/v2/parse",
		type: "POST",
		headers: {
			"Content-Type": "application/json",
			"App-Id": "1b4dd70a",
			"App-Key": "01a1ad52bd0ca896dd349f1a10b3cd0d"
		},

		data: JSON.stringify({
			"text": msg
		}),
		success: function (data) {

			console.log(data);
			console.log(data.mentions[0].common_name);
			var log = data.mentions[0].common_name;
			choice = data.mentions[0].choice_id;
			code = data.mentions[0].id;
			//code = data.mentions[]

			trueMessage(log);

			askQuestions();
			console.log("calling me");
			return;
		},
		error: function (err) {
			console.log(err);
		}
	});

}

function askQuestions() {
	var seekAge = "Could you also tell us your age?";
	trueMessage(seekAge);
	setTimeout(function () {

		var seekSex = "Could we also get your sex?";
		trueMessage(seekSex);
	}, 10000);
	//setTimeout(function(){

	//diagnose();
	//},2000);




}
//does diagnosis of the patient
function diagnose() {
	//var count = 0;
	var save = {
		"sex": sex,
		"age": age,
		"evidence": [{
			"id": code,
			"choice_id": choice,
			"initial": true
		}]
	};
	///JSON.stringify(JSON.parse(save.push(msave)));

	console.log(save);

	fake = JSON.parse(JSON.stringify({
		"id": main,
		"choice_id": myChoice
	}));
	console.log(fake);
	if (count > 0) {
		/*var builder = {};
  	builder.id = 'ghf';
  	choice_id = "fggg";
  	*/
		JSON.parse(JSON.stringify(save.evidence.push(fake)));


	}


	console.log(age);

	$.ajax({

		url: "https://api.infermedica.com/v2/diagnosis",
		method: "POST",
		headers: {
			"Content-Type": "application/json",
			"App-Id": "1b4dd70a",
			"App-Key": "01a1ad52bd0ca896dd349f1a10b3cd0d"

		},
		processData: false,

		data: JSON.stringify(save),
		success: function (data) {
			save = data;
			var safe = data;
			//save = JSON.stringify(data.evidence.push());
			console.log(save);
			count++;
			//var me = data;
			console.log("Hello" + save);
			//save.push(data.evidence);
			//count++;
			console.log(data);
			var well = "That could probably be " + data.conditions[0].name;
			trueMessage(well);
			var diag = data.question.text;
			main = data.conditions[0].id;
			console.log(main);
			trueMessage(diag);
			console.log(diag);
		},
		error: function (err) {
			console.log(err);
		}

	});
	// }
	//while(msg!="done");
}




function init_websocket() {

	websocket = new WebSocket("ws://" + ipad + ":" + port + "/");

	websocket.onopen = function (evt) {
		onOpen(evt)
	};
	websocket.onclose = function (evt) {
		onClose(evt)
	};
	websocket.onmessage = function (evt) {
		onMessage(evt)
	};
	websocket.onerror = function (evt) {
		onError(evt)
	};
}

function updateScrollbar() {
	$messages.mCustomScrollbar("update").mCustomScrollbar('scrollTo', 'bottom', {
		scrollInertia: 10,
		timeout: 0
	});
}


function onMessage(evt) {

	cries_for_server = 0;

	if (evt.data.charAt(0) != '_') {
		trueMessage(evt.data);
		state = 1;

		ifURL(evt.data)
	} else { // control messages
		/*
		if(evt.data.charAt(1) == 'p'){
			$('.message-input').val(evt.data.slice(2)); 
		}*/
	}

}

function ifURL(str) {
	var pos1 = str.search("href=");
	var pos2 = str.search("target");
	if (pos1 < 0) {
		lastURI = false;
		return;
	}
	lastURI = str.slice(pos1 + 6, pos2 - 2);
}


function onClose(evt) {

	var ERROR_MSG;
	if (state == 0 || cries_for_server >= 1) {
		ERROR_MSG = 'Server is not active! Check server...';
		trueMessage(ERROR_MSG);
		state = 2;
	} else if (state == 1 && cries_for_server < 1) {
		ERROR_MSG = 'Something went wrong. Reconnecting now...';
		trueMessage(ERROR_MSG);
		// reconnect
		init_websocket();
		cries_for_server++;
	}
}


function setDate() {
	d = new Date()
	if (m != d.getMinutes()) {
		m = d.getMinutes();
		$('<div class="timestamp">' + d.getHours() + ':' + m + '</div>').appendTo($('.message:last'));
	}
}

//insert message into bubble
function insertMessage() {

	msg = $('.message-input').val();
	$('.message-input').prop('disabled',true);

	// add message to stack
	msg_stack.push(msg);

	if ($.trim(msg) == '') {
		return false;
	}
	if (msg.charAt(0) == '>')
		$('<div class="message message-personal"><strong>' + msg.slice(1) + '</strong></div>').appendTo($('.mCSB_container')).addClass('new');
	else
		$('<div class="message message-personal">' + msg + '</div>').appendTo($('.mCSB_container')).addClass('new');
	setDate();
	$('.message-input').val('');
	updateScrollbar();
	
	switch(msgStep) {
		case 'name': 
			userData[msgStep] = msg;
			trueMessage(messages, 'age');
			break;
		case 'age':
			let age = msg.replace(/[^\d]/g,'');
			userData[msgStep] = age;
			trueMessage(messages, 'gender');
			break;
		case 'gender':
			userData[msgStep] = msg;
			trueMessage(messages, 'feeling');
			break;
		case 'feeling':
			let feeling = msg.replace(/[^\d]/g,'');
			userData[msgStep] = feeling;
			if(feeling < 7) {
				trueMessage(messages, 'not_well');
			} else {
				trueMessage(messages, 'well');
			}
			break;
	}
	// Send message to the server
	//websocket.send(msg);

	//setTimeout(function() {
	//if(sex==null){

	//infermedicaCall();
	//}
	//else{
	//diagnose();

	//}

	//ajaxRequest();
	//fakeMessage();
	//}, 1000 + (Math.random() * 20) * 100);
}


$('.message-submit').click(function () {
	if(inTransit) return;
	insertMessage();
	console.log(msg);
});

// $(window).on('keydown', function (e) {

// 	if (e.which == 13) {
// 		msg = $('.message-input').val();
// 		console.log(msg);
// 		insertMessage();
// 		return false;
// 	} else if (e.which == 38 && msg_stack.length > 0) {
// 		$('.message-input').val(msg_stack[msg_stack.length - 1]);
// 		return false;
// 	}

// })

function trueMessage(_msg_from_server, type) {
	if ($('.message-input').val() != '') {
		return false;
	}
	$('<div class="message loading new"><figure class="avatar"><img src="res/Assistant.jpg" /></figure><span></span></div>').appendTo($('.mCSB_container'));
	updateScrollbar();

	setTimeout(function () {
		$('.message.loading').remove();

		if (state == 0 || state == 2)
			$('<div class="message new"><figure class="avatar"><img src="res/Assistant.jpg" /></figure>' + _msg_from_server[type] + '</div>').appendTo($('.mCSB_container')).addClass('new');
		else
			$('<div class="message new"><figure class="avatar"><img src="res/Assistant.jpg" /></figure>' + _msg_from_server[type] + '</div>').appendTo($('.mCSB_container')).addClass('new');

		setDate();

		updateScrollbar();
		i++;
		
		msgStep = type;
		$('.message-input').prop('disabled',false);
		inTransit = false;
	}, 1000 + (Math.random() * 20) * 100);
}

// not working
function setBG() {
	var images = ['hd1.jpg', 'hd2.jpg'];
	$('html').css({
		'background-image': 'url(res/' + images[Math.floor(Math.random() * images.length)] + ')'
	});
}


// before the page is closed
window.onbeforeunload = function () {
	websocket.send('$#');
}


//disease diagnosis
