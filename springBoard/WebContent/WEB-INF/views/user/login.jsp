<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>로그인</title>
</head>
<script type="text/javascript">
	$j(document).ready(function() {
		$j("input[name='userId']").focus();
		
		<%-- 
		alert(<%=request.getAttribute("errCode")%>);
		alert(${pageContext.request.getParameter("errCode")});
		
		if(<%=request.getAttribute("errCode")%>==1){
			alert("올바르지 않은 아이디 혹 올바르지 않은 비밀번호입니다.");
		}
 --%>
 
		$j("#loginBtn").on("click", function() {
			if ($j("#userId").val() == '') {
				alert("아이디를 입력해주세요.");
				$j("#userId").focus();
				return false;
			}

			if ($j("#userPw").val() == '') {
				alert("비밀번호를 입력해주세요.");
				$j("#userPw").focus();
				return false;
			}

			$j("#loginFrm").submit();
		});
	});
</script>
<body class="pt-5">
	<div class="container">
		<div class="d-flex justify-content-center h-100">
			<div class="card">
				<!-- header -->
				<div class="card-header">
					<h3 class="py-3 font-weight-bold text-center">로그인</h3>
				</div>

				<!-- body -->
				<div class="card-body py-3">
					<form id="loginFrm" action="/user/loginAction.do" method="post">
						<div class="input-group form-group no-border">
							<div class="input-group-prepend">
								<span class="input-group-text text-center" style="width: 50px">ID</span>
							</div>
							<input type="text" class="form-control" name="userId" id="userId"
								maxlength="20">
						</div>
						<div class="input-group form-group no-border">
							<div class="input-group-prepend">
								<span class="input-group-text text-center" style="width: 50px">PW</span>
							</div>
							<input type="password" class="form-control" name="userPw" id="userPw"
								maxlength="20">
						</div>

						<div class="input-group form-group">
							<button type="button" id="loginBtn"
								class="btn btn-secondary form-control">로그인</button>
						</div>
					</form>
				</div>

				<!-- footer -->
				<div class="card-footer"></div>
			</div>
		</div>
	</div>
</body>
</html>