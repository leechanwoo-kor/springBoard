<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<script type="text/javascript">
	function ajax(n) {
		var $frm = $j('.selectType :input');
		var param = "pageNo=" + n + "&" + $frm.serialize();

		alert(param);

		$j.ajax({
			url : "/board/boardSearchAction.do",
			type : "POST",
			data : param,
			dataType : "html",
			success : function(data, textStatus, jqXHR) {
				alert("조회완료");

				$j("#divTable").html(data);
			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert("실패");
			}
		});
	}
</script>
<table align="center">
	<!-- header -->
	<c:if test="${sessionScope.user == null }">
		<tr>
			<td align="left"><a href="/user/login.do">login</a> <a
				href="/user/join.do">join</a></td>
		</tr>
	</c:if>
	<c:if test="${sessionScope.user != null }">
		<tr>
			<td align="left">${user.userName}님</td>
		</tr>
	</c:if>
	<tr id="trTotal">
		<td align="right">total : ${totalCnt}</td>
	</tr>
	<!-- header -->

	<!-- body -->

	<tr>
		<td id="tdTable">
			<table id="boardTable" border="1">
				<tr>
					<td width="80" align="center" id=type>Type</td>
					<td width="40" align="center" id=no>No</td>
					<td width="350" align="center" id=title>Title</td>
				</tr>
				<c:forEach items="${boardList}" var="list">
					<tr>
						<td align="center">${list.codeName}</td>
						<td>${list.boardNum}</td>
						<td><a
							href="/board/${list.boardType}/${list.boardNum}/boardView.do?pageNo=${pageNo}">${list.boardTitle}</a>
						</td>
					</tr>
				</c:forEach>
			</table>
		</td>
	</tr>

	<!-- pagination -->
	<tr align="center">
		<td id="tdPaging"><c:forEach begin="1" end="${(totalCnt+9)/10}"
				step="1" var="index">
				<c:choose>
					<c:when test="${pageNo ne index}">
						<a href="javascript:ajax(${index });">${index}</a>
					</c:when>
					<c:otherwise>
								${index}
							</c:otherwise>
				</c:choose>
			</c:forEach></td>
	</tr>
	<!-- pagination -->

	<!-- body -->
</table>