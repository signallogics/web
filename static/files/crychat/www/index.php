<?php
	if (isset($_GET['qrcode']))
	{
		include("phpqrcode/qrlib.php");
		$back_color = 0xFFFF00;
		$fore_color = 0xFF00FF;
		QRcode::png($_GET['qrcode'], false, 'h', 7, 1, false, $back_color, $fore_color);
		exit;
	}

	session_start();

	if (isset($_GET['username'])) {
		$username = htmlspecialchars($_GET['username']);
	} else {
		$username = 'user'.rand(100,999);
	}

	if (isset($_GET['chatid'])) {
		$_COOKIE[session_name()] = $_GET['chatid'];
	}

	if (!isset($_SESSION['chat'])) {
		$_SESSION['chat'] = array();
		$_SESSION['chat'][date('Y-m-d H:i:s')] = 'chat started';
		session_commit();
		
		$f = fopen("logger.log",'ab');
		fwrite($f,"\n chat ".session_id());
		fclose($f);
	}

	function getParam($name) {
		return isset($_GET[$name]) ? $_GET[$name] : (isset($_POST[$name]) ? $_POST[$name] : "");
	}
	
	function issetParam($name) {
		return isset($_GET[$name]) || isset($_POST[$name]);
	}

	if (issetParam('action')) {
		$action = getParam('action');
		if ($action == 'newchat') {
			session_regenerate_id(true);
			
			$f = fopen("logger.log",'ab');
			fwrite($f,"\n newchat ".session_id());
			fclose($f);
			
			$result = array(
				'result' => 'ok',
				'data' => array(),
			);
			$result['data']['session_id'] = session_id();
			$_SESSION['chat'] = array();
			$_SESSION['chat'][date('Y-m-d H:i:s')] = 'chat started';
			session_commit();
			header('Content-Type: application/json');
			echo json_encode($result);
			exit;
		} else if($action == 'addmsg') {
			$f = fopen("logger.log",'ab');
			fwrite($f,"\n add msg ".session_id());
			fclose($f);
			
			$result = array(
				'result' => 'fail',
				'data' => array(),
			);
			if (issetParam('msg')) {
				$_SESSION['chat'][date('Y-m-d H:i:s')] = htmlspecialchars(getParam('msg'));
				session_commit();
				$result['result'] = 'ok';
			}
			header('Content-Type: application/json');
			echo json_encode($result);
			exit;
		} else if ($action == 'clear') {
			$f = fopen("logger.log",'ab');
			fwrite($f,"\n clear ".session_id());
			fclose($f);
			
			$result = array(
				'result' => 'ok',
				'data' => array(),
			);
	
			$_SESSION['chat'] = array();
			$_SESSION['chat'][date('Y-m-d H:i:s')] = 'chat clean';
			session_commit();
			header('Content-Type: application/json');
			echo json_encode($result);
			exit;
		} else if ($action == 'messages') {
			header('Content-Type: application/json');
			$result = array(
				'data' => $_SESSION['chat'],
				'result' => 'ok',
			);
			echo json_encode($result);
			exit;
		}
	}
?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title># crychat - your secret chat </title>

<!-- CSS files begin-->
<link rel="stylesheet" type="text/css" href="css/jquery.jscrollpane.css" media="all"/>
<link rel="stylesheet" type="text/css" href="css/prettyPhoto.css" media="all" />
<link rel="stylesheet" type="text/css" href="css/style.css" media="all"/>

<!-- JavaScript files begin-->
<script type="text/javascript" src="js/jquery-1.6.4.min.js"></script>
<script type="text/javascript" src="js/cufon-yui.js"></script>
<script type="text/javascript" src="js/Yanone_Kaffeesatz_400-700.font.js"></script>
<script type="text/javascript" src="js/jquery.prettyPhoto.js"></script>
<script type="text/javascript" src="js/jquery.form.js"></script>
<script type="text/javascript" src="js/jquery.ufvalidator-1.0.5.js"></script>
<script type="text/javascript" src="js/jquery.easing.1.3.js"></script>
<script type="text/javascript" src="js/jquery.mousewheel.js"></script>
<script type="text/javascript" src="js/jquery.jscrollpane.js"></script>
<script type="text/javascript" src="js/jquery.progression.1.3.js"></script>
<script type="text/javascript" src="js/jquery.text-effects.js"></script>
<script type="text/javascript" src="js/custom.js"></script>
<script type="text/javascript">
	
	function getParameterByName(name) {
		name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
		var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
			results = regex.exec(location.search);
		return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
	}
	
	var session_id = "<?php echo session_id(); ?>";
	var session_name = "<?php echo session_name(); ?>";
	if (getParameterByName('chatid') != "") {
		session_id = getParameterByName('chatid');
		var date = new Date( new Date().getTime() + (7 * 24 * 60 * 60 * 1000) ); // cookie on week
		document.cookie = session_name + "=" + encodeURIComponent(session_id) + "; path=/; expires="+date.toUTCString();

	}

	function makeChatLink(session_id_) {
		if (session_id_ != session_id)
			session_id = session_id_;

		var path = location.pathname.split("/");
		path.splice(path.indexOf('index.php'), 1);
		var newURL = location.protocol + '//' + location.host + path.join("/") + "/" + "index.php?chatid=" + session_id_;
		document.getElementById('chatid').innerHTML = '<a class="chatid" href="' + newURL + '">' + newURL + '</a>';
		document.getElementById('qrcode_link').src= '?qrcode=' + encodeURIComponent(newURL);
	};

	function createUrlFromObj(obj) {
	    var str = "";
	    for (k in obj) {
	        if (str.length > 0)
	            str += "&";
	        str += encodeURIComponent(k) + "=" + encodeURIComponent(obj[k]);
	    }
	    return str;
	}

	function send_request_post(params, callbackf) {
	    var tmpXMLhttp = null;
	    if (window.XMLHttpRequest) {
	        // code for IE7+, Firefox, Chrome, Opera, Safari
	        tmpXMLhttp = new XMLHttpRequest();
	    };
	    tmpXMLhttp.onreadystatechange = function() {
	        if (tmpXMLhttp.readyState == 4 && tmpXMLhttp.status == 200) {
	            if (tmpXMLhttp.responseText == "")
	                alert("error");
	            else {
	                try {
	                    var obj = JSON.parse(tmpXMLhttp.responseText);
	                    callbackf(obj);
	                } catch (e) {
	                    alert("Error in js " + e.name + " on request \nResponse:\n" + tmpXMLhttp.responseText);
	                }
	                tmpXMLhttp = null;
	            }
	        }
	    }
	    tmpXMLhttp.open("POST", 'index.php', true);
	    tmpXMLhttp.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
	    tmpXMLhttp.send(createUrlFromObj(params));
	};
	
	function updateChat(runagain) {
	    var params = {};
	    params['action'] = 'messages';
	    send_request_post(
	        params,
	        function(obj) {
				var el = document.getElementById('chat');
	            if (obj.result == "fail") {
					el.innerHTML = "fail";
	            } else {
					el.innerHTML = "";
	                for (var k in obj.data) {
	                    if (obj.data.hasOwnProperty(k)) {
	                        el.innerHTML += "<p class='line'>[" + k + "] " + obj.data[k] + '</p>';
	                    }
	                }
	                el.scrollTop = el.scrollHeight;
	            }
	            if (runagain == true)
					setTimeout(function() { updateChat(true); }, 2000);
	        }
	    );
	}
	
	function sendMessage() {
	    var params = {};
	    params['action'] = 'addmsg';
	    params['msg'] = document.getElementById('username').value + ": "+ document.getElementById('message').value;
		if (params.msg.trim() == "") {
			return;
		}
	    send_request_post(
	        params,
	        function(obj) {
	            if (obj.result == "ok") {
					document.getElementById('message').value = "";
					updateChat(false);
	            }
	        }
	    );
	}

	function createNewChat() {
		var params = {};
	    params['action'] = 'newchat';
	    send_request_post(
	        params,
	        function(obj) {
	            if (obj.result == "ok") {
					makeChatLink(obj.data.session_id);
					updateChat(false);
	            }
	        }
	    );
	}
	
	function clearChat() {
		var params = {};
	    params['action'] = 'clear';
	    send_request_post(
	        params,
	        function(obj) {
	            if (obj.result == "ok") {
					updateChat(false);
	            }
	        }
	    );
	}
</script>
</head>

<body onload="updateChat(true); makeChatLink(session_id);">

    <!-- wrappage begin here -->
    <div id="wrappage">
        <!-- container begin here -->
        <div class="container">
            <!-- top block begin here -->
            <div class="top">
                <div class="top-block">
                    <a href="index.html" class="logo">
                        # crychat
                    </a>
                </div>
            </div>
            <!-- top block end here -->
            <!-- center block begin here -->
            <div class="center-block">
                <!-- scanner begin here -->
                <!-- scanner end here -->
                <!-- main begin here -->
                <div class="main">
                    <div class="page">
                        <div id="chatid" class="chatid"> 
								<?php
									echo 'ChatLink: '.session_id().'  ';
								?>
						</div>
                        
						<div id="newchatpage" class="box left">
							<div id="chat" class="box-content">
							</div>
						</div>

						<div class="pnls">
							<div class="pnl">
								<label class="label1">Name:</label>
								<input type="text" class="textfield" id="username" value="<?php echo $username; ?>" />
							<div>
							<div class="pnl">
								<label class="label1">Message:</label>
								<input type="text" class="textfield" id="message" value="" onkeyup="if (event.keyCode == 13) sendMessage();" />
							</div><br>

							<a class="a1" href="javascript:void(0);" onclick="sendMessage();">send</a>
							<a class="a1" href="javascript:void(0);" onclick="createNewChat();">new chat</a>
							<a class="a1" href="javascript:void(0);" onclick="clearChat();">clean up chat</a>
						</div>
                    </div>
                </div>
                <!-- main end here -->
            </div>
            <!-- bottom block end here -->
            
        </div>
        <!-- container end here -->
        
    </div>
    <!-- wrappage end here -->
    <img class="imgqrcode" id="qrcode_link" src="?qrcode=1"/>
</body>
</html>
