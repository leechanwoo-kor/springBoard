<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardWrite</title>
</head>

<!-- 가상키보드 -->
<script type="text/javascript" charset="UTF-8">

function is_hangul_char(ch) {
	c = ch.charCodeAt(0);
	if( 0x1100<=c && c<=0x11FF ) return true;
	if( 0x3130<=c && c<=0x318F ) return true;
	if( 0xAC00<=c && c<=0xD7A3 ) return true;
	return false;
}

var eng=[['`','1','2','3','4','5','6','7','8','9','0','-','=','←'],['tab','q','w','e','r','t','y','u','i','o','p','[',']','\\'],['caps lock','a','s','d','f','g','h','j','k','l','enter'],['shift','z','x','c','v','b','n','m',',','.','/','한/영'],['space']]
var shiftEng=[['~','!','@','#','$','%','^','&','*','(',')','_','+','←'],['tab','Q','W','E','R','T','Y','U','I','O','P','{','}','|'],['caps lock','A','S','D','F','G','H','J','K','L','enter'],['shift','Z','X','C','V','B','N','M','<','>','?','한/영'],['space']]
var kor=[['`','1','2','3','4','5','6','7','8','9','0','-','=','←'],['tab','ㅂ','ㅈ','ㄷ','ㄱ','ㅅ','ㅛ','ㅕ','ㅑ','ㅐ','ㅔ','[',']','\\'],['caps lock','ㅁ','ㄴ','ㅇ','ㄹ','ㅎ','ㅗ','ㅓ','ㅏ','ㅣ','enter'],['shift','ㅋ','ㅌ','ㅊ','ㅍ','ㅠ','ㅜ','ㅡ',',','.','/','한/영'],['space']]
var shiftKor=[['~','!','@','#','$','%','^','&','*','(',')','_','+','←'],['tab','ㅃ','ㅉ','ㄸ','ㄲ','ㅆ','ㅛ','ㅕ','ㅑ','ㅒ','ㅖ','{','}','|'],['caps lock','ㅁ','ㄴ','ㅇ','ㄹ','ㅎ','ㅗ','ㅓ','ㅏ','ㅣ','enter'],['shift','ㅋ','ㅌ','ㅊ','ㅍ','ㅠ','ㅜ','ㅡ','<','>','?','한/영'],['space']]
var HANGUL_OFFSET = 0xAC00,
	COMPLETE_CHO = ['ㄱ', 'ㄲ', 'ㄴ', 'ㄷ', 'ㄸ', 'ㄹ', 'ㅁ', 'ㅂ', 'ㅃ', 'ㅅ', 'ㅆ', 'ㅇ', 'ㅈ', 'ㅉ', 'ㅊ', 'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ'],
	COMPLETE_JUNG = ['ㅏ', 'ㅐ', 'ㅑ', 'ㅒ', 'ㅓ', 'ㅔ', 'ㅕ', 'ㅖ', 'ㅗ', 'ㅘ', 'ㅙ', 'ㅚ', 'ㅛ', 'ㅜ', 'ㅝ', 'ㅞ', 'ㅟ', 'ㅠ', 'ㅡ', 'ㅢ', 'ㅣ'],
	COMPLETE_JONG = ['', 'ㄱ', 'ㄲ', 'ㄳ', 'ㄴ', 'ㄵ', 'ㄶ', 'ㄷ', 'ㄹ', 'ㄺ', 'ㄻ', 'ㄼ', 'ㄽ', 'ㄾ', 'ㄿ', 'ㅀ', 'ㅁ', 'ㅂ', 'ㅄ', 'ㅅ', 'ㅆ', 'ㅇ', 'ㅈ', 'ㅊ', 'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ'],
	COMPLEX_CONSONANTS = [['ㄱ','ㅅ','ㄳ'],['ㄴ','ㅈ','ㄵ'],['ㄴ','ㅎ','ㄶ'],['ㄹ','ㄱ','ㄺ'],['ㄹ','ㅁ','ㄻ'],['ㄹ','ㅂ','ㄼ'],['ㄹ','ㅅ','ㄽ'],['ㄹ','ㅌ','ㄾ'],['ㄹ','ㅍ','ㄿ'],['ㄹ','ㅎ','ㅀ'],['ㅂ','ㅅ','ㅄ']],
	COMPLEX_VOWELS = [['ㅗ','ㅏ','ㅘ'],['ㅗ','ㅐ','ㅙ'],['ㅗ','ㅣ','ㅚ'],['ㅜ','ㅓ','ㅝ'],['ㅜ','ㅔ','ㅞ'],['ㅜ','ㅣ','ㅟ'],['ㅡ','ㅣ','ㅢ']];

var ga = 44032;

/* $j(document).on("focusout",".inputKeyboard",function(){
  var keyboard=$j("#keyboard");
  keyboard.empty();
});  */

var kk=0;/* 키보드 */
$j(document).on("click","#inputKeyboard",function(){
	if(kk==0){
		$j(this).focus();
		var keyboard=$j("#keyboard");
	
		var thisId = $j(this).attr('class');
		var parentId= $j(this).parent().parent().parent().parent().parent().parent().parent().parent().parent().parent().attr('id');
		keyboard.attr('name',parentId+','+thisId)
		keyboard.empty();
		show_keyboard(eng);
		kk=1;
	}else{
		var keyboard=$j("#keyboard");
		keyboard.empty();
		kk=0;
	}
});

/* 키보드 생성 */
function show_keyboard(obj){
	for(var i=0;i<obj.length;i++){
		var ul = document.createElement('ul');
		for(var j=0;j<obj[i].length;j++){
			var li = document.createElement('li');
			var key= document.createTextNode( obj[i][j] );
			li.appendChild( key );

			if( obj[i][j]=='enter'){
				li.style="width:200px";
			}else if(obj[i][j]=='한/영'){
				li.style="width:150px";
			}else if(obj[i][j]=='space'){
				li.style="width:700px";
			}
			ul.appendChild(li);
		}
		document.getElementById('keyboard').appendChild(ul);   
	}
}

/* 키보드 변환 */
function change_keyboard(language,lanArr){
	var keyboard=$j("#keyboard");
	keyboard.empty();
	show_keyboard(lanArr);
	$j("#langu").attr("value",language);
}


var shiftCnt=0;
/* 문자 입력 */
$j(document).on("click","li",function(){  
	var spt = $j(this).parent().parent().attr('name').split(',');
	var $area = $j("#"+spt[0]).find("."+spt[1]);
	var input = $area.val();

	$area.focus();
	
	var text = $j(this).text();

	if(text=="space"){
		text =" ";
		$area.val(input + text);

	}else if(text=="tab"){
    	text ="    ";
		$area.val(input + text);

	}else if(text=="한/영"){
		if($j("#langu").val()=="eng" || $j("#langu").val()=="shiftEng" ){
			change_keyboard('kor',kor);
		}else{
			change_keyboard('eng',eng);
	}

	}else if(text=="caps lock" ){
		if($j("#langu").val()=="eng"){
			change_keyboard('shiftEng',shiftEng);
		}else if($j("#langu").val()=="shiftEng"){
			change_keyboard('eng',eng);
		}
	}else if(text=="shift"){
		shiftCnt=1;

		if($j("#langu").val()=="eng"){
			change_keyboard('shiftEng',shiftEng);
		}else if($j("#langu").val()=="shiftEng"){
			change_keyboard('eng',eng);
		}else if($j("#langu").val()=="kor"){
			change_keyboard('shiftKor',shiftKor);
		}else if($j("#langu").val()=="shiftKor"){
			change_keyboard('kor',kor);
		}
	}else if(text=="←"){
    	$area.val(input.slice(0,-1));
	}else if(text=="enter"){
		text="\n";
		$area.val(input + text);
	}else{ //특수키 제외 === 글자 입력
    	var lastText = input.substring(input.length-1);
		var code= lastText.charCodeAt(0);

		loop:if(is_hangul_char(text)){//입력글자가 한글이라면

        if(is_hangul_char(lastText)){//마지막 문자가 한글이라면 
			if(0xAC00 <= code && code <= 0xd7a3){ //마지막문자가 조합이라면
				code = code-ga;
				var fn = parseInt(code / 588);  //초성인덱스
				var sn= parseInt((code - (fn * 588)) / 28);    // 중성 인덱스 
				var tn = parseInt(code % 28); //종성 인덱스
 
			if(tn>0){ // 종성이 이미 있을때
            	if(COMPLETE_CHO.indexOf(text)>-1){ //자음
                	for(var i =0;i<COMPLEX_CONSONANTS.length;i++){// ㅂ+ㅅ= ㅄ
                    	if(COMPLEX_CONSONANTS[i][0]==COMPLETE_JONG[tn] && COMPLEX_CONSONANTS[i][1]==text){
							var newTn =COMPLETE_JONG.indexOf(COMPLEX_CONSONANTS[i][2]);
 
							text = String.fromCharCode( 0xAC00 + 21*28*fn + 28*sn+newTn);
							$area.val(input.slice(0,-1) + text);
							break loop;
						}
					}
					// ㅂ+ㄱ=ㅂㄱ
					$area.val(input + text);

				}else{//모음
                	for(var i =0;i<COMPLEX_CONSONANTS.length;i++){//값+ㅏ -> 갑사 
                    	if(COMPLEX_CONSONANTS[i][2]==COMPLETE_JONG[tn]){
                        	var newTn = COMPLETE_JONG.indexOf(COMPLEX_CONSONANTS[i][0]);

							var text1 = String.fromCharCode( 0xAC00 + 21*28*fn + 28*sn+newTn); //갑

							var newFn=COMPLETE_CHO.indexOf(COMPLEX_CONSONANTS[i][1]); 
							var newSn=COMPLETE_JUNG.indexOf(text);
							var text2= String.fromCharCode( 0xAC00 + 21*28*newFn + 28*newSn);//사

							$area.val(input.slice(0,-1) + text1+text2);
							break loop;
						}
					}
                      
                    //갑+ㅏ -> 가바
                    var text1 = String.fromCharCode( 0xAC00 + 21*28*fn + 28*sn);//가
                    
                    var newFn=COMPLETE_CHO.indexOf(COMPLETE_JONG[tn]);
                    var newSn=COMPLETE_JUNG.indexOf(text);
                    var text2 = String.fromCharCode( 0xAC00 + 21*28*newFn + 28*newSn);//바
  
					$area.val(input.slice(0,-1) + text1+text2);

				}
			}else{//종성이 없을때
            	if(COMPLETE_CHO.indexOf(text)>-1){ //자음
                	if(COMPLETE_JONG.indexOf(text)>-1){//가+ㅅ=갓 
                    	var newTn=COMPLETE_JONG.indexOf(text);
                        	text = String.fromCharCode( 0xAC00 + 21*28*fn + 28*sn +newTn);
							$area.val(input.slice(0,-1) + text);
					}else{//따+ㄸ=따ㄸ
                    	$area.val(input + text);
                    }
                    
				}else{//모음
                	for(var i =0;i<COMPLEX_VOWELS.length;i++){// 고+ㅏ=과 
                    	if(COMPLEX_VOWELS[i][0]==COMPLETE_JUNG[sn] && COMPLEX_VOWELS[i][1]==text){
                        	var newSn=COMPLETE_JUNG.indexOf( COMPLEX_VOWELS[i][2]);
							text = String.fromCharCode( 0xAC00 + 21*28*fn + 28*newSn );
							$area.val(input.slice(0,-1) + text);
							break loop;
						}
					}
                    // 스+ㅓ=스ㅓ
                    $area.val(input + text);
				}
			}
  
		}else{//단타라면
			if(COMPLETE_CHO.indexOf(text)>-1){ //자음
            	if(COMPLETE_CHO.indexOf(lastText)>-1){//자음+자음 
                	for(var i =0;i<COMPLEX_CONSONANTS.length;i++){//ㄱ+ㅅ=ㄳ
                    	if(COMPLEX_CONSONANTS[i][0]==lastText && COMPLEX_CONSONANTS[i][1]==text){
                        	text = COMPLEX_CONSONANTS[i][2];
							$area.val(input.slice(0,-1) + text);
							break loop;
						}
					}
                    //ㄱ+ㄹ=ㄱㄹ
					$area.val(input + text);

                   
                          }else{//모음+자음
                             //ㅏ+ㄱ=ㅏㄱ
                             $area.val(input + text); 
                        }
              
              }else if(COMPLETE_JUNG.indexOf(text)>-1){ //모음
                       if(COMPLETE_CHO.indexOf(lastText)>-1){//자음+모음
                          //ㄱ+ㅏ=가
                          var lastCode= COMPLETE_CHO.indexOf(lastText);
                          var textCode= COMPLETE_JUNG.indexOf(text);
                          text = String.fromCharCode( 0xAC00 + 21*28*lastCode + 28*textCode );
                          $area.val(input.slice(0,-1) + text);
                       }else{//모음+모음
                          for(var i =0;i<COMPLEX_VOWELS.length;i++){// ㅗ+ㅏ=ㅘ
                             if(COMPLEX_VOWELS[i][0]==lastText && COMPLEX_VOWELS[i][1]==text){
                                text = COMPLEX_VOWELS[i][2];
                                $area.val(input.slice(0,-1) + text);
								break loop;
                        	}
						}
                        // ㅗ+ㅡ=ㅗㅡ
                    	$area.val(input + text);
                	}
            	}
        	}
		}else{//마지막 문자가 영어
       		$area.val(input + text);
    	}
	}else{//입력글자가 영어라면 바로 입력
    	$area.val(input + text);
	}

	if(shiftCnt>0){
    	if($j("#langu").val()=="eng"){
			change_keyboard('shiftEng',shiftEng);
        }else if($j("#langu").val()=="shiftEng"){
			change_keyboard('eng',eng);
        }else if($j("#langu").val()=="kor"){
        	change_keyboard('shiftKor',shiftKor);
		}else if($j("#langu").val()=="shiftKor"){
        	change_keyboard('kor',kor);
        }

        shiftCnt=0;
    	}
	}
});

</script>

<script type="text/javascript" charset="UTF-8">
	$j(document).ready(function() {
		/* 첫 포커스 */
		$j("input[name='boardTitle']").focus();

		$j("#submit").on("click",function() {
			if ($j('.boardTitle').val() == '') {
				alert('제목을 작성해 주세요');
				$j('.boardTitle').focus();

				return false;
			}

			if ($j('.boardComment').val() == '') {
				alert('내용을 작성해 주세요');
				$j('.boardComment').focus();

				return false;
			}

			$j(".boardWrite").each(function(index, form) {
				$j(form).find(".boardType").attr('name','boardVoList[' + index + '].boardType');
				$j(form).find(".boardTitle").attr('name','boardVoList[' + index + '].boardTitle');
				$j(form).find(".boardComment").attr('name','boardVoList[' + index + '].boardComment');
				$j(form).find(".creator").attr('name','boardVoList[' + index + '].creator');
			});

			var sData = $j('.boardWrite')
					.serialize();
			console.log(sData);

		

			$j.ajax({
				url : "/board/boardWriteAction.do",
				type : "POST",
				data : sData,
				traditional : true,
				success : function(data,textStatus,jqXHR) {
					alert("작성완료");
					/* alert("메세지:" + data.success); */

					location.href = "/board/boardList.do";
				},
				error : function(jqXHR,textStatus,errorThrown) {
					console.log(boardVoList);
					alert("실패");
				}
			});
		});
	});

	function serialize() {

		$j("form").each(function(index) {
			$j(".boardType").attr('name','boardVoList[' + index + '].boardType');
			$j(".boardTitle").attr('name','boardVoList[' + index + '].boardTitle');
			$j(".boardComment").attr('name','boardVoList[' + index + '].boardComment');
			$j(".creator").attr('name','boardVoList[' + index + '].creator');
		});

		var sData = $j('.boardWrite').serialize();
		console.log(sData);
	}

	var count = 1;

	function addForm() {

		var frms = document.getElementById("frms");

		var html = "";
		html += '<form class="boardWrite" name="boardWrite" action="" method="post">';
		html += '<table align="center"><tr><td align="right"><input id="del#" type="button" value="행삭제" onclick="delForm();"></td></tr>';
		html += '<tr><td><table border="1"><tr><td width="120" align="center">Type</td>';
		html += '<td><select class="boardType" name="boardType" id="boardType">';
		html += '<c:forEach var="codeVo" items="${codeNameList}" varStatus="status">';
		html += '<option value="${codeVo.codeId}">${codeVo.codeName}</option></c:forEach></select></td></tr>';
		html += '<tr><td width="120" align="center">Title</td><td width="400"><input class="boardTitle" name="boardTitle" id="boardTitle" type="text" size="50" value="" maxlength="25"></td></tr>';
		html += '<tr><td height="200" align="center">Comment</td><td valign="top"><textarea class="boardComment" name="boardComment" id="boardComment" rows="10" cols="55" class="keyboardInput"></textarea></td></tr>';
		html += '<c:if test="${sessionScope.user == null }"><tr><td align="center">Writer</td><td><input class="creator" name="creator" id="creator" type="hidden" value="SYSTEM">SYSTEM</td></tr></c:if>';
		html += '<c:if test="${sessionScope.user != null }"><tr><td align="center">Writer</td><td><input class="creator" name="creator" id="creator" type="text" size="50" value="${user.userName}" readonly></td></tr></c:if>';
		html += '</tr></table></td></tr></table><br>';
		html += '</form>';
	
		var formDiv = document.createElement("div");
		formDiv.id = "formDiv";
		formDiv.innerHTML = html;
		frms.appendChild(formDiv);

		$j("input[name='boardTitle']").focus();

		count++;
		/* document.boardWrite.count.value = count; */

	}

	function delForm() {
		var frms = document.getElementById("frms");

		if (count > 1) {
			var formDiv = document.getElementById("formDiv");
			frms.removeChild(formDiv);
			$j("input[name='boardTitle']").focus();

			count--;
			/* document.boardWrite.count.value = count; */
		} else {
			document.boardWrite.reset();
			$j("input[name='boardTitle']").focus();
		}
	}
	
</script>

<style type="text/css">
ul,li {list-style:none;}
#keyboard {padding:10px;}
#keyboard ul {overflow:hidden;margin:0;padding:0;} 
#keyboard li {float:left; text-align:center; border:1px solid #c8c8c8; margin:0;padding:0;}
/* #keyboard {background:#eee;} */
#keyboard li {background:#fff;}

#keyboard li {width:50px; height:50px; cursor:pointer;}
#keyboard li:hover{
   background:#555;color:#fff;

}
</style>


<body>
	<div id="frms">
		<form class="boardWrite" name="boardWrite" action="" method="post">
			<!-- <input type="hidden" name="count" value="1"> -->

			<table align="center">
				<tr>
					<td align="right"><input type="button" value="체크"
						onclick="serialize();"> <a href="/board/boardList.do">List</a>
						<input id="submit" type="button" value="작성"> <input
						id="add#" type="button" value="행추가" onclick="addForm();"></td>
				</tr>
				<tr>
					<td>
						<table border="1">
							<tr>
								<td width="120" align="center">Type</td>
								<td><select class="boardType" name="boardType" id="boardType">
										<c:forEach var="codeVo" items="${codeNameList}"
											varStatus="status">
											<option value="${codeVo.codeId}">${codeVo.codeName}</option>
										</c:forEach>
								</select></td>
							</tr>
							<tr>
								<td width="120" align="center">Title</td>
								<td width="400"><input class="boardTitle" name="boardTitle" id="inputKeyboard"
						 type="text" size="50" value="${board.boardTitle}" maxlength="25"></td>
							</tr>
							<tr>
								<td height="200" align="center">Comment</td>
								<td valign="top"><textarea class="boardComment"name="boardComment"
										id="inputKeyboard" rows="10" cols="55">${board.boardComment}</textarea></td>
							</tr>
							<c:if test="${sessionScope.user == null }">
								<tr>
									<td align="center">Writer</td>
									<td><input class="creator" name="creator" id="creator" type="hidden"
										value="SYSTEM">SYSTEM</td>
								</tr>
							</c:if>
							<c:if test="${sessionScope.user != null }">
								<tr>
									<td align="center">Writer</td>
									<td><input class="creator" name="creator" id="creator" type="text"
										size="50" value="${user.userName}" readonly></td>
								</tr>
							</c:if>
						</table>
					</td>
				</tr>
			</table>
			<br>

		</form>
		
		<input type="hidden" id="langu" value="eng">
		<div class="keyboard" id="keyboard" align="center">
		</div>
	</div>
	
	
	
</body>
</html>