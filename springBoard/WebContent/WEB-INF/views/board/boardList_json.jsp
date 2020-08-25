<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>list</title>
</head>
<script type="text/javascript">
	$j(document).ready(function() {
		/* 체크 전체 선택, 해제 */
		$j("#checkAll").click(function(){
			if($j("#checkAll").prop("checked")){
				$j(".typeCk").prop("checked", true);
			}else{
				$j(".typeCk").prop('checked',false);
			}
		});

		var codeNameLength = ${fn:length(codeNameList)};
		
		/* 한개 체크박스 해제 시 전체 체크박스 해제 */
		$j(".typeCk").click(function(){
			if($j("input[name='codeId']:checked").length == codeNameLength){
				$j("#checkAll").prop("checked", true);
			}else{
				$j("#checkAll").prop("checked", false);
			}
		});	
		
		/* 
		$j("#btnSearch").click(function(){
			$j('#selectType').submit();
		});
		 */
		
		$j("#btnSearch").click(function(){
			var $frm = $j('.selectType :input');
			var param = $frm.serialize();
			/* 
			alert(param);
			 */
			$j.ajax({
				url : "/board/boardSearchAction.do",
				type : "POST",
				data : param,
				success : function(data, textStatus, jqXHR) {
					alert("조회완료");
					
					$j("#trTotal").html("");
					$j("#trTotal").append('<td align="right">total : ' +
										 data[0].totalCnt + '</td>');
					
					$j("#tdTable").html("");
					
					var html = '';
					html += '<table id="boardTable" border="1">';
					html += '<tr>';
					html += '<td width="80" align="center" id=type>Type</td>';
					html += '<td width="40" align="center" id=no>No</td>';
					html += '<td width="350" align="center" id=title>Title</td>';
					html += '</tr>';
					
					 for(var i = 0; i < data.length; i++){
						html += '<tr>';
						html += '<td align="center">' + data[i].codeName + '</td>';
						html += '<td>' + data[i].boardNum + '</td>';
						html += '<td> <a href="/board/' + data[i].boardType +
								'/' + data[i].boardNum + '/boardView.do?pageNo=1">' + 
								data[i].boardTitle + '</td>';
						html += '</tr>';
					}
					
					html += '</table>';					
					
					$j("#tdTable").append(html);
					
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert("실패");
				}
			});
			
		});
		
	});
	
	
</script>

<!-- 게시물 리스트 페이지 -->
<body>
	<form id="selectType" class="selectType" method="get"
		action="/board/boardList.do">
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
			<!-- body -->

			<c:if test="${sessionScope.user == null }">
				<tr>
					<td align="right"><a href="/board/boardWrite.do">글쓰기</a></td>
				</tr>
			</c:if>
			<c:if test="${sessionScope.user != null }">
				<tr>
					<td align="right"><a href="/board/boardWrite.do">글쓰기 </a> <a
						href="/user/logout.do">로그아웃</a></td>
				</tr>
			</c:if>

			<!-- checkBox -->
			<tr>
				<td align="left"><input type="checkbox" class="typeCk"
					id="checkAll" value="all">전체 <c:forEach var="codeVo"
						items="${codeNameList}" varStatus="status">
						<input type="checkbox" class="typeCk" name="codeId"
							value="${codeVo.codeId}">${codeVo.codeName}</>					
					</c:forEach> <input type="button" id="btnSearch" value="조회"></td>
			</tr>

			<!-- pagination -->
			<tr align="right">
				<td><c:forEach begin="1" end="${(totalCnt+9)/10}" step="1"
						var="index">
						<c:choose>
							<c:when test="${pageNo ne index}">
								<a href="/board/boardList.do?pageNo=${index}">${index}</a>
							</c:when>
							<c:otherwise>
								${index}
							</c:otherwise>
						</c:choose>
					</c:forEach></td>
			</tr>

		</table>
	</form>
</body>
</html>