ipad="10.0.0.3"
port="8001"

  function init()
  {
	document.getElementById("appendedInputButton").focus();
    websocket = new WebSocket("ws://"+ipad+":"+port+"/");
    websocket.onopen = function(evt) { onOpen(evt) };
    websocket.onclose = function(evt) { onClose(evt) };
    websocket.onmessage = function(evt) { onMessage(evt) };
    websocket.onerror = function(evt) { onError(evt) };
  }

  function onOpen(evt)
  {
    	
	document.myform.connectButton.disabled = true;
	document.myform.disconnectButton.disabled = false;
	
  }

  function onClose(evt)
  {
  alert("dis-connected");
	document.myform.connectButton.disabled = false;
	document.myform.disconnectButton.disabled = true;
  }

  function onMessage(evt)
  {
    
	
	var text=evt.data;
	document.getElementById("appendedInputButton").focus();
	writeToScreen('<div class="cont" id="cont_bot"> '+text+'</div>');
  }

  function onError(evt)
  {
    alert('error: ' + evt.data);

	websocket.close();

	document.myform.connectButton.disabled = false;
	document.myform.disconnectButton.disabled = true;

  }

  function doSend(message)
  {
    
    websocket.send(message);
  }

  function writeToScreen(message)
  {
    document.getElementById("chat-messages").innerHTML += message
document.getElementById("chat-messages").scrollTop = document.getElementById("chat-messages").scrollHeight;

  }

  window.addEventListener("load", init, false);


   function sendText() 
  {
		var x=document.getElementById("appendedInputButton").value;
		if(x!="")
		{
			doSend(x);
			var text=x;
		
			writeToScreen('<div class="cont_ser" id="cont_user"> '+text+'</div>');
			clearText();
		}
   }

  function clearText() {
		document.getElementById("appendedInputButton").value = "";
   }

   function doDisconnect() {
		websocket.close();
   }
function readSingleFile(e)
{
  var file = e.target.files[0];
  if (!file) 
  {
    return;
  }
  var reader = new FileReader();
  reader.onload = function(e) 
  {
    var contents = e.target.result;
    displayContents(contents);
  };
  reader.readAsText(file);
}

function displayContents(contents) {
  var element = document.getElementById('file-content');
  element.innerHTML = contents;
}

