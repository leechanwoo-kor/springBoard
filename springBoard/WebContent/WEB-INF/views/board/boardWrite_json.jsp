<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardWrite</title>
</head>
<script type="text/javascript">
	$j(document).ready(function() {
		/* 첫 포커스 */
		$j("input[name='boardTitle']").focus();

		$j("#submit").on("click",function() {
			if ($j('#boardTitle').val() == '') {
				alert('제목을 작성해 주세요');
				$j('#boardTitle').focus();

				return false;
			}

			if ($j('#boardComment').val() == '') {
				alert('내용을 작성해 주세요');
				$j('#boardComment').focus();

				return false;
			}
			/* 
			var $frm = $j('.boardWrite :input');
			var param = $frm.serialize();
			 */

			var boardList = new Array();

			for (var i = 0; i < count; i++) {
				var obj = new Object();
				obj["boardType"] = document
						.getElementsByName('boardType')[i].value;
				obj["boardTitle"] = document
						.getElementsByName('boardTitle')[i].value;
				obj["boardComment"] = document
						.getElementsByName('boardComment')[i].value;
				obj["creator"] = document
						.getElementsByName('creator')[i].value;

				boardList.push(obj);
			}

			var data = new Object();

			data["boardVoList"] = boardList;
			data["count"] = count;
			console.log(data);

			$j.ajax({
				contentType : 'application/json',
				url : "/board/boardWriteAction.do",
				type : "POST",
				dataType : "json",
				data : JSON.stringify(data),
				success : function(
						data,
						textStatus,
						jqXHR) {

					alert("작성완료");

					alert("메세지:"
							+ data.success);

					location.href = "/board/boardList.do";
				},
				error : function(jqXHR,
						textStatus,
						errorThrown) {
					console
							.log(boardList);
					console
							.log(JSON
									.stringify(data));
					alert("실패");
				}
			});
		});
	});

	var count = 1;

	function addForm() {

		var frms = document.getElementById("frms");

		var html = "";
		html += '<table align="center"><tr><td align="right"><input id="del#" type="button" value="행삭제" onclick="delForm();"></td></tr>';
		html += '<tr><td><table border="1"><tr><td width="120" align="center">Type</td>';
		html += '<td><select name="boardType" id="boardType"><option value="a01">일반</option><option value="a02">Q&A</option>';
		html += '<option value="a03">익명</option><option value="a04">자유</option></select></td>';
		html += '<tr><td width="120" align="center">Title</td><td width="400"><input name="boardTitle" id="boardTitle" type="text" size="50" value="" maxlength="25"></td></tr>';
		html += '<tr><td height="200" align="center">Comment</td><td valign="top"><textarea name="boardComment" id="boardComment" rows="10" cols="55" class="keyboardInput"></textarea></td></tr>';
		html += '<c:if test="${sessionScope.user == null }"><tr><td align="center">Writer</td><td><input name="creator" id="creator" type="hidden" value="SYSTEM">SYSTEM</td></tr></c:if>';
		html += '<c:if test="${sessionScope.user != null }"><tr><td align="center">Writer</td><td><input name="creator" id="creator" type="text" size="50" value="${user.userName}" readonly></td></tr></c:if>';
		html += '</tr></table></td></tr></table><br>';

		var formDiv = document.createElement("div");
		formDiv.id = "formDiv";
		formDiv.innerHTML = html;
		frms.appendChild(formDiv);

		$j("input[name='boardTitle']").focus();

		count++;
		document.boardWrite.count.value = count;

	}

	function delForm() {
		var frms = document.getElementById("frms");

		if (count > 1) {
			var formDiv = document.getElementById("formDiv");
			frms.removeChild(formDiv);
			$j("input[name='boardTitle']").focus();

			count--;
			document.boardWrite.count.value = count;
			alert(count);
		} else {
			document.boardWrite.reset();
			$j("input[name='boardTitle']").focus();
		}
	}

</script>



<!-- --------가상키보드-------- -->
<script type="text/javascript" src="/resources/js/VK.js" charset="UTF-8"></script>
<script type="text/javascript" src="/resources/js/virtualkeyboard.js"
	charset="UTF-8"></script>
<link rel="stylesheet" type="text/css"
	href="/resources/css/virtualkeyboard.css">

<script type="text/javascript">
function VK_buildKeyboardInputs() {
	var self = this;
	this.VK_target = this.VK_visible= "";
	this.VK_shift = this.VK_capslock = this.VK_alternate = false;
	this.VK_kt = "KR"; // 기본 키보드 레이아웃
	this.VK_range = false;
	this.VK_keyCenter = 3;
	
	/* 키보드 생성 */
	this.VK_layout = new Object();
	this.VK_layoutDDK = new Object();
	
	this.VKI_layout.KR = [ // Korea Standard Keyboard
	    [["`", "~"], ["1", "!"], ["2", "@"], ["3", "#"], ["4", "$"], ["5", "%"], ["6", "^"], ["7", "&"], ["8", "*"], ["9", "("], ["0", ")"], ["-", "_"], ["=", "+"], ["Bksp", "Bksp"]],
	    [["Tab", "Tab"], ["ㅂ", "ㅃ"], ["ㅈ", "ㅉ"], ["ㄷ", "ㄸ"], ["ㄱ", "ㄲ"], ["ㅅ", "ㅆ"], ["ㅛ", "ㅛ"], ["ㅕ", "ㅕ"], ["ㅑ", "ㅑ"], ["ㅐ", "ㅒ"], ["ㅔ", "ㅖ"], ["[", "{"], ["]", "}"], ["\\", "|"]],
	    [["Caps", "Caps"], ["ㅁ", "ㅁ"], ["ㄴ", "ㄴ"], ["ㅇ", "ㅇ"], ["ㄹ", "ㄹ"], ["ㅎ", "ㅎ"], ["ㅗ", "ㅗ"], ["ㅓ", "ㅓ"], ["ㅏ", "ㅏ"], ["ㅣ", "ㅣ"], [";", ":"], ["'", '"'], ["Enter", "Enter"]],
	    [["Shift", "Shift"], ["ㅋ", "ㅋ"], ["ㅌ", "ㅌ"], ["ㅊ", "ㅊ"], ["ㅍ", "ㅍ"], ["ㅠ", "ㅠ"], ["ㅜ", "ㅜ"], ["ㅡ", "ㅡ"], [",", "＜"], [".", ">"], ["/", "?"], ["Shift", "Shift"]],
	    [[" ", " "]]
	];

	this.VKI_layout.US = [ // US Standard Keyboard
		[["`", "~"], ["1", "!"], ["2", "@"], ["3", "#"], ["4", "$"], ["5", "%"], ["6", "^"], ["7", "&"], ["8", "*"], ["9", "("], ["0", ")"], ["-", "_"], ["=", "+"], ["Bksp", "Bksp"]],
	    [["Tab", "Tab"], ["q", "Q"], ["w", "W"], ["e", "E"], ["r", "R"], ["t", "T"], ["y", "Y"], ["u", "U"], ["i", "I"], ["o", "O"], ["p", "P"], ["[", "{"], ["]", "}"], ["\\", "|"]],
	    [["Caps", "Caps"], ["a", "A"], ["s", "S"], ["d", "D"], ["f", "F"], ["g", "G"], ["h", "H"], ["j", "J"], ["k", "K"], ["l", "L"], [";", ":"], ["'", '"'], ["Enter", "Enter"]],
	    [["Shift", "Shift"], ["z", "Z"], ["x", "X"], ["c", "C"], ["v", "V"], ["b", "B"], ["n", "N"], ["m", "M"], [",", "＜"], [".", ">"], ["/", "?"], ["Shift", "Shift"]],
	    [[" ", " "]]
	];
	
	var kr = Array('ㅂ','ㅃ','ㅈ','ㅉ','ㄷ','ㄸ','ㄱ','ㄲ','ㅅ','ㅆ','ㅛ','ㅛ','ㅕ','ㅕ','ㅑ','ㅑ','ㅐ','ㅒ','ㅔ','ㅖ','ㅁ','ㅁ','ㄴ','ㄴ','ㅇ','ㅇ','ㄹ','ㄹ','ㅎ','ㅎ','ㅗ','ㅗ','ㅓ','ㅓ','ㅏ','ㅏ','ㅣ','ㅣ','ㅋ','ㅋ','ㅌ','ㅌ','ㅊ','ㅊ','ㅍ','ㅍ','ㅠ','ㅠ','ㅜ','ㅜ','ㅡ','ㅡ')
	var us = Array('q','Q','w','W','e','E','r','R','t','T','y','Y','u','U','i','I','o','O','p','P','a','A','s','S','d','D','f','F','g','G','h','H','j','J','k','K','l','L','z','Z','x','X','c','C','v','V','b','B','n','N','m','M')
	
	
	/* input & textarea 태그 */
	var inputElems = [
		document.getElementsByTagName('input'),
	    document.getElementsByTagName('textarea'),
	]
	
	for(var x = 0, inputCount = 0, elem; elem = inputElems[x++];) {
		if(elem){
			for(var y = 0; keyid = "", ex; ex = elem[y++];) {
				if((ex.nodeName == "TEXTAREA" || ex.type == "text" || ex.type == "password") && ex.className.indexOf("keyboardInput") > -1) {
					if(!ex.id){
						do {keyid = 'keyboardInputInitiator' + inputCount++; }
						while (document.getElementById(keyid));
					} else keyid = ex.id;
					
					var keybut = document.createElement('img');
						keybut.src = "http://www.blueb.co.kr/SRC/javascript/image8/keyboard.png";
						keybut.alt = "Keyboard interface";
						keybut.className = "keyboardInputInitiator";
						keybut.title = "Display graphical keyboard interface";
					ex.parentNode.insertBefore(keybut, ex.nextSibling);
					if(!window.sidebar && !window.opera) {
						ex.onclick = ex.onkeyup = ex.onselect = function() {
							if(self.VK_target.createTextRange) self.VK_range = document.selection.createRange();
						};
					}
				}
			}
		}
	}
	
	/* 키보드 인터페이스 생성 */
	this.VK_keyboard = document.createElement('table');
	this.VK_keyboard.id = "keyboardInputMaster";
	this.VK_keyboard.cellSpacing = this.VK_keyboard.cellPadding = this.VK_keyboard.border = "0";

	var layouts = 0;
	for(ktype in this.VK_layout)
		if(typeof this.VK_layout[ktype] == "object")
			layouts++;
	
	var thead = document.createElement('thead');
	var tr = document.createElement('tr');
	var th = document.createElement('th');
	if(layouts > 1) {
		var kblist = document.createElement('select');
		for(ktype in this.VK_layout){
			if(typeof this.VK_layout[ktype] == "object"){
				var opt = document.createElement('option');
					opt.value = ktype;
					opt.appendChild(document.createTextNode(ktype));
				kblist.appendChild(opt);
			}
		}
		kblist.value = this.VK_kt;
		kblist.onchange = function() {
			self.VK_kt = this.value;
			self.VK_buildKeys();
			self.VK_position();
		};
		th.appendChild(kblist);
	}
	tr.appendChild(th);
	
	var td = document.createElement('td');
	var clearer = document.createElement('span');
		clearer.id = "keyboardInputClear";
		clearer.appendChild(document.createTextNode("Clear"));
        clearer.title = "Clear this input";
        clearer.onmousedown = function() { this.className = "pressed"; };
        clearer.onmouseup = function() { this.className = ""; };
        clearer.onclick = function() {
        	self.VK_target.value = "";
        	document.getElementById('eng_text').value='';
        	self.VK_target.focus();
        	return false;
        };
        td.appendChild(clearer);
        
	var closer = document.createElement('span');
		closer.id = "keyboardInputClose";
	    closer.appendChild(document.createTextNode('X'));
	    closer.title = "Close this window";
	    closer.onmousedown = function() { this.className = "pressed"; };
	    closer.onmouseup = function() { this.className = ""; };
	    closer.onclick = function() {self.VK_close();};
	    td.appendChild(closer);
	    
	tr.appendChlid(td);
	thead.appendChild(tr);
	this.VK_keyboard.appendChild(thead);
	
	var tbody = document.createElement('tbody');
	var tr = document.createElement('tr');
	var td = document.createElement('td');
		td.colSpan = "2";
	var div = document.createElement('div');
		div.id = "keyboardInputLayout";
		td.appendChild(div);
	var div = document.createElement('div');
	var ver = document.createElement('var');
		ver.appendChild(document.createTextNode("v" + this.VKI_version));
	    div.appendChild(ver);
	    td.appendChild(div);
	    tr.appendChild(td);
	    tbody.appendChild(tr);
	this.VKI_keyboard.appendChild(tbody);
		
	
	/* 키보드 생성 */
	this.VK_buildKeys = function() {
	    this.VK_shift = this.VK_capslock = this.VK_alternate = false;

	    var container = this.VK_keyboard.tBodies[0].getElementsByTagName('div')[0];
	    while (container.firstChild)
	    	container.removeChild(container.firstChild);

	    for (var x = 0, hasDeadKey = false, lyt; lyt = this.VK_layout[this.VK_kt][x++];) {
		var table = document.createElement('table');
			table.cellSpacing = table.cellPadding = table.border = "0";
		if (lyt.length() <= this.VK_keyCenter)
			table.className = "keyboardInputCenter";
		var tbody = document.createElement('tbody');
		var tr = document.createElement('tr');
	    for (var y = 0, lkey; lkey = lyt[y++];) {
	    	var td = document.createElement('td');
	    		td.appendChild(document.createTextNode(lkey[0]));

			var alive = false;
	        
			if (this.VK_deadkeysOn)
	        	for (key in this.VKI_deadkey)
	        		if (key === lkey[0])
	        			alive = true;
			td.className = (alive) ? "alive" : "";
	        
			if (lyt.length > this.VKI_keyCenter && y == lyt.length)
	        	td.className += " last";

			if (lkey[0] == " ")
	        	td.style.paddingLeft = td.style.paddingRight = "50px";
	            td.onmouseover = function() { 
	            	if (this.className != "dead" && this.firstChild.nodeValue != "\xa0") 
	            		this.className += " hover"; 
	            };
	            td.onmouseout = function() { 
	            	if (this.className != "dead") 
	            		this.className = this.className.replace(/ ?(hover|pressed)/g, ""); 
	            };
	            td.onmousedown = function() { 
	            	if (this.className != "dead" && this.firstChild.nodeValue != "\xa0") 
	            		this.className += " pressed"; 
	            };
	            td.onmouseup = function() { 
	            	if (this.className != "dead") 
	            		this.className = this.className.replace(/ ?pressed/g, ""); 
	            };
	            td.ondblclick = function() { 
	            	return false; 
	            };

			switch (lkey[1]) {
	        	case "Caps":
	            case "Shift":
	            case "Alt":
	            case "AltGr":
	            	td.onclick = (function(type) { 
	            		return function() { 
	            			self.VK_modify(type); 
	            			return false; 
	            		}
	            	})(lkey[1]);
					break;
				case "Tab":
					td.onclick = function() { self.VK_insert("\t"); return false; };
	                break;
				case "Bksp":
	            	td.onclick = function() {
	                	self.VKI_target.focus();
	                    if (self.VK_target.setSelectionRange) {
	                    	var srt = self.VK_target.selectionStart;
							var len = self.VK_target.selectionEnd;	
							if (srt < len) 
								srt++;
							self.VK_target.value = self.VK_target.value.substr(0, srt - 1) + self.VK_target.value.substr(len);
							self.VK_target.setSelectionRange(srt - 1, srt - 1);
	                    } else if (self.VK_target.createTextRange) {
							try { self.VK_range.select(); } catch(e) {}
							self.VKI_range = document.selection.createRange();
							if (!self.VK_range.text.length) 
								self.VK_range.moveStart('character', -1);
							self.VK_range.text = "";
	                    } else 
	                    	self.VK_target.value = self.VK_target.value.substr(0, self.VKI_target.value.length - 1);
	                    
	                    if (self.VK_shift) self.VK_modify("Shift");
	                    if (self.VK_alternate) self.VK_modify("AltGr");

	                    if(self.VK_kt=='KR'){
	                      var eng_span=document.getElementById('eng_text')
	                      eng_span.value=eng_span.value.substring(0,eng_span.value.length-1)

	                      englishToKorean(self.VK_target,eng_span)
	                    }
	                    return true;
	                  };
	                  break;
				case "Enter":
	            	td.onclick = function() {
	                if (self.VK_target.nodeName == "TEXTAREA") { 
	                	self.VK_insert("\n"); } 
	                else self.VKI_close();
	                    return true;
					};
	                break;
				default:
	            	td.onclick = function() {
	                	if (self.VK_deadkeysOn && self.VK_dead) {
	                    	if (self.VK_dead != this.firstChild.nodeValue) {
								for (key in self.VK_deadkey) {
		                        	if (key == self.VK_dead) {
										if (this.firstChild.nodeValue != " ") {
											for (var z = 0, rezzed = false, dk; dk = self.VK_deadkey[key][z++];) {
		                                		if (dk[0] == this.firstChild.nodeValue) {
		                                  			self.VK_insert(dk[1]);
		                                  			rezzed = true;
													break;
		                                		}
		                              		}
		                            	} else {
		                              		self.VK_insert(self.VK_dead);
		                              		rezzed = true;
		                            	}
		                            break;
		                          	}
		                        }
							} else rezzed = true;
						}
						self.VK_dead = false;

	                    if (!rezzed && this.firstChild.nodeValue != "\xa0") {
	                    	if (self.VK_deadkeysOn) {
	                        	for (key in self.VK_deadkey) {
	                          		if (key == this.firstChild.nodeValue) {
	                            	self.VK_dead = key;
	                            	this.className = "dead";
	                            	if (self.VK_shift) 
	                            		self.VK_modify("Shift");
	                            	if (self.VK_alternate) 
	                            		self.VK_modify("AltGr");
	                            	break;
	                          		}
	                        	}
	                        	if (!self.VK_dead) 
	                        		self.VK_insert(this.firstChild.nodeValue);
	                      	} else 
	                      		self.VK_insert(this.firstChild.nodeValue);
	                    }

	                    self.VK_modify("");
	                    return false;
					};
				}
	            tr.appendChild(td);
	            tbody.appendChild(tr);
	          	table.appendChild(tbody);

	          	for (var z = lkey.length; z ＜ 4; z++) 
	          		lkey[z] = "\xa0";
	    	}
	    container.appendChild(table);
	    }
	  };

	  this.VK_buildKeys();
	  VK_disableSelection(this.VK_keyboard);
}

</script>

<body>

	<form class="boardWrite" name="boardWrite" action="" method="post">
		<input type="hidden" name="count" value="1">

		<table align="center">
			<tr>
				<td align="right"><a href="/board/boardList.do">List</a> <input
					id="submit" type="button" value="작성"> <input id="add#"
					type="button" value="행추가" onclick="addForm();"></td>
			</tr>
			<tr>
				<td>
					<table border="1">
						<tr>
							<td width="120" align="center">Type</td>
							<td><select name="boardType" id="boardType">
									<c:forEach var="codeVo" items="${codeNameList}"
										varStatus="status">
										<option value="${codeVo.codeId}">${codeVo.codeName}</option>
									</c:forEach>
							</select></td>
						</tr>
						<tr>
							<td width="120" align="center">Title</td>
							<td width="400"><input name="boardTitle" id="boardTitle" class="inputKeyboard"
								type="text" size="50" value="${board.boardTitle}" maxlength="25"></td>
						</tr>
						<tr>
							<td height="200" align="center">Comment</td>
							<td valign="top"><textarea name="boardComment"
									id="boardComment" rows="10" cols="55" class="inputKeyboard">${board.boardComment}</textarea></td>
						</tr>
						<c:if test="${sessionScope.user == null }">
							<tr>
								<td align="center">Writer</td>
								<td><input name="creator" id="creator" type="hidden"
									value="SYSTEM">SYSTEM</td>
							</tr>
						</c:if>
						<c:if test="${sessionScope.user != null }">
							<tr>
								<td align="center">Writer</td>
								<td><input name="creator" id="creator" type="text"
									size="50" value="${user.userName}" readonly></td>
							</tr>
						</c:if>
					</table>
				</td>
			</tr>
		</table>
		<br>

		<div id="frms"></div>

	</form>

	<input type="hidden" id="langu" value="eng">
	<div class="keyboard" id="keyboard" align="center"></div>
</body>
</html>