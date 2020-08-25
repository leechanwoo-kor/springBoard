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
			
			
			var $frm = $j('.boardWrite :input');
			var param = $frm.serialize();

			alert("count: " + count);
			alert(param);
			
			if(count>1){
				$j.ajax({
					url : "/board/boardWriteAction2.do",
					dataType : "json",
					type : "POST",
					data : param,
					success : function( data, textStatus, jqXHR) {
						alert("작성완료");
	
						alert("메세지:" + data.success);
	
						location.href = "/board/boardList.do";
					},
					error : function(jqXHR, textStatus, errorThrown) {
						alert("실패");
					}
				});
			}else{
				$j.ajax({
					url : "/board/boardWriteAction.do",
					dataType : "json",
					type : "POST",
					data : param,
					success : function(data, textStatus, jqXHR) {
						alert("작성완료");
	
						alert("메세지:" + data.success);
	
						location.href = "/board/boardList.do";
					},
					error : function(jqXHR, textStatus, errorThrown) {
						alert("실패");
					}
				});
			}
		});
	});

	var count = 1;
	
	function addForm() {
		
		var frms = document.getElementById("frms");

		var html = "";
		html += '<table align="center"><tr><td align="right"><input id="del#" type="button" value="행삭제" onclick="delForm();"></td></tr>';
		html += '<tr><td><table border="1"><tr><td width="120" align="center">Type</td>';
		html += '<td><select name="boardType"><option value="a01">일반</option><option value="a02">Q&A</option>';
		html += '<option value="a03">익명</option><option value="a04">자유</option></select></td>';
		html += '<tr><td width="120" align="center">Title</td><td width="400"><input name="boardTitle" type="text" size="50" value="" maxlength="25"></td></tr>';
		html += '<tr><td height="200" align="center">Comment</td><td valign="top"><textarea name="boardComment" rows="10" cols="55" class="keyboardInput"></textarea></td></tr>';
		html += '<c:if test="${sessionScope.user == null }"><tr><td align="center">Writer</td><td><input name="creator" type="hidden" value="SYSTEM">SYSTEM</td></tr></c:if>';
		html += '<c:if test="${sessionScope.user != null }"><tr><td align="center">Writer</td><td><input name="creator" type="text" size="50" value="' + ${user.userName} + '" readonly></td></tr></c:if>';
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
		}else {
			document.boardWrite.reset();
			$j("input[name='boardTitle']").focus();
		}
	}
</script>

<script type="text/javascript" src="/resources/js/keyboard.js" charset="UTF-8"></script>
<link rel="stylesheet" type="text/css" href="/resources/css/keyboard.css">

<body>
	<form class="boardWrite" name="boardWrite" action="" method="post">
		<input type="hidden" name="count" value="1">

		<table align="center">
			<tr>
				<td align="right"><a href="/board/boardList.do">List</a> <input
					id="submit" type="button" value="작성"> <input id="add#"
					type="button" value="행추가" onclick="addForm();"> </td>
			</tr>
			<tr>
				<td>
					<table border="1">
						<tr>
							<td width="120" align="center">Type</td>
							<td><select name="boardType">
									<option value="a01">일반</option>
									<option value="a02">Q&A</option>
									<option value="a03">익명</option>
									<option value="a04">자유</option>
							</select></td>
						</tr>
						<tr>
							<td width="120" align="center">Title</td>
							<td width="400"><input name="boardTitle" type="text"
								size="50" value="${board.boardTitle}" maxlength="25"></td>
						</tr>
						<tr>
							<td height="200" align="center">Comment</td>
							<td valign="top"><textarea name="boardComment" rows="10"
									cols="55" class="keyboardInput">${board.boardComment}</textarea></td>
						</tr>
						<c:if test="${sessionScope.user == null }">
							<tr>
								<td align="center">Writer</td>
								<td><input name="creator" type="hidden" value="SYSTEM">SYSTEM</td>
							</tr>
						</c:if>
						<c:if test="${sessionScope.user != null }">
							<tr>
								<td align="center">Writer</td>
								<td><input name="creator" type="text" size="50"
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