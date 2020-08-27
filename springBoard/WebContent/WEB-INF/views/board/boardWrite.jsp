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

			for(var i = 0; i<count ; i++){
				var obj = new Object();
				obj["boardType"] = document.getElementsByName('boardType')[i].value;
				obj["boardTitle"] = document.getElementsByName('boardTitle')[i].value;
				obj["boardComment"] = document.getElementsByName('boardComment')[i].value;
				obj["creator"] = document.getElementsByName('creator')[i].value;
				
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
				success : function(data, textStatus, jqXHR) {
					
					alert("작성완료");

					alert("메세지:" + data.success);

					location.href = "/board/boardList.do";
				},
				error : function(jqXHR, textStatus, errorThrown) {
					console.log(boardList);
					console.log(JSON.stringify(data));
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

		if(count>1){
			var formDiv = document.getElementById("formDiv");
			frms.removeChild(formDiv);
			$j("input[name='boardTitle']").focus();
			
			count--;
			document.boardWrite.count.value = count;
			alert(count);
		}else {
			document.boardWrite.reset();
			$j("input[name='boardTitle']").focus();
		}
	}
	
	function check(){
		var boardType = $j("#boardType :input");
		var boardTitle = $j("#boardTitle :input");
		var boardComment = $j("#boardComment :input");
		var creator = $j("#creator :input");
		
		var boardList = new Array();

		for(var i = 0; i<count ; i++){
			var obj = {"boardType":document.getElementsByName('boardType')[i].value,
						"boardTitle":document.getElementsByName('boardTitle')[i].value,
						"boardComment":document.getElementsByName('boardComment')[i].value,
						"creator":document.getElementsByName('creator')[i].value};
			
			boardList.push(obj);
		}
		alert(boardList);
	}
	
</script>

<script type="text/javascript" src="/resources/js/keyboard.js" charset="UTF-8"></script>
<link rel="stylesheet" type="text/css" href="/resources/css/keyboard.css">

<body>
	<form class="boardWrite" name="boardWrite" action="" method="post">
		<input type="hidden" name="count" value="1">

		<table align="center">
			<tr>
				<td align="right">
					<input id="chk" type="button" value="chk" onclick="check()"> 
					<a href="/board/boardList.do">List</a> 
					<input id="submit" type="button" value="작성"> 
					<input id="add#" type="button" value="행추가" onclick="addForm();"> 
				</td>
			</tr>
			<tr>
				<td>
					<table border="1">
						<tr>
							<td width="120" align="center">Type</td>
							<td><select name="boardType" id="boardType">
							<c:forEach var="codeVo" items="${codeNameList}" varStatus="status">
									<option value="${codeVo.codeId}">${codeVo.codeName}</option>
							</c:forEach>
							</select></td>
						</tr>
						<tr>
							<td width="120" align="center">Title</td>
							<td width="400"><input name="boardTitle" id="boardTitle" type="text"
								size="50" value="${board.boardTitle}" maxlength="25"></td>
						</tr>
						<tr>
							<td height="200" align="center">Comment</td>
							<td valign="top"><textarea name="boardComment" id="boardComment" rows="10"
									cols="55" class="keyboardInput">${board.boardComment}</textarea></td>
						</tr>
						<c:if test="${sessionScope.user == null }">
							<tr>
								<td align="center">Writer</td>
								<td><input name="creator" id="creator" type="hidden" value="SYSTEM">SYSTEM</td>
							</tr>
						</c:if>
						<c:if test="${sessionScope.user != null }">
							<tr>
								<td align="center">Writer</td>
								<td><input name="creator" id="creator" type="text" size="50"
									value="${user.userName}" readonly></td>
							</tr>
						</c:if>
					</table>
				</td>
			</tr>
		</table><br>

		<div id="frms"></div>
	</form>
</body>
</html>