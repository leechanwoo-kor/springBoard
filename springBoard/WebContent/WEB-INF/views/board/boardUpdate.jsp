<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardUpdate</title>
</head>
<script type="text/javascript">
	$j(document).ready(function() {
		/* 첫 포커스 */
		$j("input[name='boardTitle']").focus();

		$j("#submit").on("click", function() {
			var $frm = $j('.boardUpdate :input');
			var param = $frm.serialize();

			$j.ajax({
				url : "/board/boardUpdateAction.do",
				dataType : "json",
				type : "POST",
				data : param,
				success : function(data, textStatus, jqXHR) {
					alert("수정완료");

					alert("메세지:" + data.success);

					location.href = "/board/boardList.do";
				},
				error : function(jqXHR, textStatus, errorThrown) {
					//alert(param);
					alert("실패");
				}
			});
		});
	});
</script>
<body>
	<form class="boardUpdate">
		<table align="center">
			<tr>
				<td>
					<table border="1">
						<tr>
							<td width="120" align="center">Title</td>
							<td width="400"><input name="boardTitle" type="text"
								size="50" value="${board.boardTitle}"></td>
						</tr>
						<tr>
							<td height="300" align="center">Comment</td>
							<td valign="top"><textarea name="boardComment" rows="20"
									cols="55">${board.boardComment}</textarea></td>
						</tr>
						<tr>
							<td align="center">Writer</td>
							<td><input name="modifier" type="text" size="50"
								value="${board.creator}" readonly></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr align="right">
				<td><a href="/board/boardList.do">List</a></td>
				<td><a href="#" id="submit">Update</a></td>
			</tr>
		</table>

		<input name="boardNum" type="hidden" value="${board.boardNum}">
		<input name="boardType" type="hidden" value="${board.boardType}">
	</form>
</body>
</html>