<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardView</title>
</head>
<script type="text/javascript">
	$j(document).ready(function() {

		$j("#submit").on("click", function() {
			if (!confirm("삭제하시겠습니까?")) {
		        return;
		    }
			
			var $frm = $j('.boardDelete :input');
			var param = $frm.serialize();

			$j.ajax({
				url : "/board/boardDeleteAction.do",
				dataType : "json",
				type : "POST",
				data : param,
				success : function(data, textStatus, jqXHR) {
					alert("삭제완료");

					alert("메세지:" + data.success);

					location.href = "/board/boardList.do";
				},
				error : function(jqXHR, textStatus, errorThrown) {
					//alert(param);
					alert("이미 삭제된 게시물입니다.");
				}
			});
		});
	});
</script>
<body>
	<form class="boardDelete">
		<table align="center">
			<tr>
				<td>
					<table border="1">
						<tr>
							<td width="120" align="center">Title</td>
							<td width="400">${board.boardTitle}</td>
						</tr>
						<tr>
							<td height="300" align="center">Comment</td>
							<td>${board.boardComment}</td>
						</tr>
						<tr>
							<td align="center">Writer</td>
							<td>${board.creator}</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr align="right">
				<td><a href="/board/boardList.do">List</a></td>
				<td><a
					href="/board/${board.boardType}/${board.boardNum}/boardUpdate.do">Update</a></td>
				<td><a id="submit" href="#">Delete</a></td>
			</tr>
		</table>

		<input name="boardNum" type="hidden" value="${board.boardNum}">
		<input name="boardType" type="hidden" value="${board.boardType}">
	</form>
</body>
</html>