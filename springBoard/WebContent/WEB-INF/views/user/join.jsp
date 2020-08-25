<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>userJoin</title>
</head>
<script type="text/javascript">
	$j(document).ready(function() {
		/* 첫 포커스 */
		$j("input[name='userId']").focus();
		
		
    	/* 아이디 중복 체크 */	var idCheck = 0;
		$j("#checkBtn").on('click', function() {
			var userId = $j("input[name='userId']").val();
			
			$j.ajax({
				type : 'POST'
				,data : {'userId':userId}
				,url : '/user/checkId.do'
				,success : function(data) {
					if (data==1) {
						$j(".alertId")
						.removeClass("alert-positive")
						.addClass("alert-negative")
						.html("<small style='color:red'>중복된 아이디 입니다.</small>");
						$j("input[name='userPw']").focus();
						idCheck = 0;
					} else if(userId==''){
						$j(".alertId")
						.removeClass("alert-positive")
						.addClass("alert-negative")
						.html("<small style='color:red'>아이디를 입력하세요.</small>");
						$j("input[name='userPw']").focus();
						idCheck = 0;
					} else{
						$j(".alertId")
						.removeClass("alert-negative")
						.addClass("alert-positive")
						.html("<small style='color:blue'>사용가능한 아이디 입니다.</small>");
						$j("input[name='userPw']").focus();
						idCheck = 1;
					}
				}
			})
		});
		

		/* 아이디 */
		$j("#userId").blur(function(){
			var userId = $j(this).val();
			
			if(userId != ''){
			}else{
				$j(".alertId")
				.removeClass("alert-positive")
				.addClass("alert-negative")
				.html("<small style='color:red'>필수 값 입니다.</small>");
			}
		});
		$j("#userId").keyup(function(){
			idCheck = 0;
			
			var engCheck = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g;
			
			if(engCheck.test(this.value)){
				this.value = this.value.replace(/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, "");
				alert("영문 또는 숫자만 입력 가능합니다.");
			}
			
			if($j("#userId").focus()){
				$j(".alertId")
				.removeClass("alert-negative")
				.addClass("alert-positive")
				.html("<small style='color:blue'></small>");
			}
		});

		/* 비밀번호 */
		$j("#userPw").keyup(function(){
			var userPw = $j(this).val();
			var userPwCk = $j("#userPwCk").val();

			
			if(userPw != ''){
				if (userPw.length < 6 || userPw.length > 12){
					$j(".alertPass")
					.removeClass("alert-positive")
					.addClass("alert-negative")
					.html("<small style='color:red'>길이가 맞지 않습니다.</small>");
				} else {
					$j(".alertPass")
					.removeClass("alert-negative")
					.addClass("alert-positive")
					.html("<small style='color:blue'>사용 가능한 비밀번호입니다.</small>");
				}
				
				if(userPw==userPwCk){
					$j(".alertPass2")
					.removeClass("alert-negative")
					.addClass("alert-positive")
					.html("<small style='color:blue'>비밀번호와 일치합니다.</small>");
				}else{
					if(userPwCk != ''){
						$j(".alertPass2")
						.removeClass("alert-positive")
						.addClass("alert-negative")
						.html("<small style='color:red'>비밀번호와 일치하지 않습니다.</small>");
					}
				}
			}
		});
		$j("#userPw").blur(function(){
			var userPw = $j(this).val();
			if(userPw != ''){
			}else{
				$j(".alertPass")
				.removeClass("alert-positive")
				.addClass("alert-negative")
				.html("<small style='color:red'>필수 값 입니다.</small>");
			}
		});
		
		/* 비밀번호 확인 */
		$j("#userPwCk").keyup(function(){
			var userPw = $j("#userPw").val();
			var userPwCk = $j(this).val();
			
			if(userPwCk != ''){
				if(userPw==userPwCk){
					$j(".alertPass2")
					.removeClass("alert-negative")
					.addClass("alert-positive")
					.html("<small style='color:blue'>비밀번호와 일치합니다.</small>");
				}else{
					$j(".alertPass2")
					.removeClass("alert-positive")
					.addClass("alert-negative")
					.html("<small style='color:red'>비밀번호와 일치하지 않습니다.</small>");
				}
			}
		});
		$j("#userPwCk").blur(function(){
			var userPwCk = $j(this).val();
			if(userPwCk != ''){
			}else{
				$j(".alertPass2")
				.removeClass("alert-positive")
				.addClass("alert-negative")
				.html("<small style='color:red'>필수 값 입니다.</small>");
			}
		});
		
		/* 이름 */
		$j("#userName").blur(function(){
			var userName = $j(this).val();
			
			if(userName != ''){
				$j(".alertName")
				.removeClass("alert-negative")
				.addClass("alert-positive")
				.html("<small style='color:blue'></small>");
			}else{
				$j(".alertName")
				.removeClass("alert-positive")
				.addClass("alert-negative")
				.html("<small style='color:red'>필수 값 입니다.</small>");
			}
		});
		$j("#userName").keyup(function(){
			// 한글만 체크
			var nameCheck = /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"\\]/g;
			
			if(nameCheck.test(this.value)){
				this.value = this.value.replace(/[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"\\]/g, "");
				alert("한글만 입력 가능합니다.");
			}
			
			if ($(this).val().length > $(this).attr('maxlength')) { 
				alert('이름은 최대 5글자 까지 입력 가능합니다.'); 
				$(this).val($(this).val().substr(0, $(this).attr('maxlength'))); 
			}

		});
		
		/* 번호 */
		$j("#userPhone2").blur(function(){
			var userPhone2 = $j(this).val();
			
			if(userPhone2 != ''){				
				if(userPhone2.length!=4){
					$j(".alertPhone")
					.removeClass("alert-positive")
					.addClass("alert-negative")
					.html("<small style='color:red'>앞자리 4자리를 모두 입력해주세요.</small>");
				}else if($j("#userPhone3").val().length!=4){
					$j(".alertPhone")
					.removeClass("alert-positive")
					.addClass("alert-negative")
					.html("<small style='color:red'>뒷자리 4자리를 모두 입력해주세요.</small>");
				}else{
				$j(".alertPhone")
				.removeClass("alert-negative")
				.addClass("alert-positive")
				.html("<small style='color:blue'></small>");
				}
			}else{
				$j(".alertPhone")
				.removeClass("alert-positive")
				.addClass("alert-negative")
				.html("<small style='color:red'>필수 값 입니다.</small>");
			}
		});
		$j("#userPhone2").keyup(function(){
			// 숫자만 체크
			var numCheck = /[^0-9]+$/;
			
			if(numCheck.test(this.value)){
				this.value = this.value.replace(/[^0-9]+$/, "");
				alert("숫자만 입력 가능합니다.");
			}
		});
		$j("#userPhone3").blur(function(){
			var userPhone3 = $j(this).val();
			
			if(userPhone3 != ''){				
				if($j("#userPhone2").val().length!=4){
					$j(".alertPhone")
					.removeClass("alert-positive")
					.addClass("alert-negative")
					.html("<small style='color:red'>앞자리 4자리를 모두 입력해주세요.</small>");
				}else if(userPhone3.length!=4){
					$j(".alertPhone")
					.removeClass("alert-positive")
					.addClass("alert-negative")
					.html("<small style='color:red'>뒷자리 4자리를 모두 입력해주세요.</small>");
				}else{
					$j(".alertPhone")
					.removeClass("alert-negative")
					.addClass("alert-positive")
					.html("<small style='color:blue'></small>");
				}
			}else{
				$j(".alertPhone")
				.removeClass("alert-positive")
				.addClass("alert-negative")
				.html("<small style='color:red'>필수 값 입니다.</small>");
			}
		});
		$j("#userPhone3").keyup(function(){
			// 숫자만 체크
			var numCheck = /[^0-9]+$/;
			
			if(numCheck.test(this.value)){
				this.value = this.value.replace(/[^0-9]+$/, "");
				alert("숫자만 입력 가능합니다.");
			}
		});
		
		
		/* 우편번호 */ var addr1Check = 0;
		$j("#userAddr1").keyup(function() {	
				var userAddr1 = $j(this).val();
				
				var numCheck = /[^0-9]+$/;
				
				var number = userAddr1;
				
			    if(number.length < 4) {
			    	if(numCheck.test(number)){				
						number = number.replace(/[^0-9]+$/, "");
				    	alert("숫자만 입력 가능합니다.");
					}
			    	this.value = number;
			    } else if(number.length < 8) {
			    	if(numCheck.test(number)){				
						number = number.replace(/[^0-9]+$/, "");
						
					}
			    	var post = "";
			        post += number.substr(0, 3);
			    	post += "-";
			    	post += number.substr(3);
			    	post = post.replace("--","-");
			    	this.value = post;
			    } 
		});
		$j("#userAddr1").blur(function() {
			
			let postPattern = /^[0-9]{3}-[0-9]{3}$/;
			
    		if(!postPattern.test($j('#userAddr1').val())){	
    			$j(".alertAddr1")
    			.removeClass("alert-positive")
    			.addClass("alert-negative")
    			.html("<small style='color:red'>000-000 형식으로 입력해주세요.</small>");
    			addr1Check = 0;
    		}else{
    			$j(".alertAddr1")
    			.removeClass("alert-negative")
    			.addClass("alert-positive")
    			.html("<small style='color:black'>000-000 형식으로 입력해주세요.</small>");
    			addr1Check = 1;
    		}
    		
    		if($j("#userAddr1").val() == ''){
    			$j(".alertAddr1")
    			.removeClass("alert-negative")
    			.addClass("alert-positive")
    			.html("<small style='color:black'>000-000 형식으로 입력해주세요.</small>");
    			addr1Check = 1;
    		}
		});

		
		/* 회원가입 */
		$j('#joinBtn').on('click', function() {
			if ($j('#userId').val() == '') {

				alert('아이디를 입력해 주세요');
				$j('#userId').focus();

				return false;
			}
			
			if(idCheck == 0){
				
				alert('아이디 중복확인을 해주십시오.');
				
				return false;
			}

			if ($j('#userPw').val() == '') {

				alert('비밀번호를 입력해 주세요');
				$j('#userPw').focus();

				return false;
			}

			if ($j('#userPwCk').val() == '') {

				alert('비밀번호 확인을 입력해 주세요');
				$j('#userPwCk').focus();

				return false;
			}
			
			var userPw = $j("#userPw").val();
			var userPwCk = $j("#userPwCk").val();
			
			if(userPw!=userPwCk) {
				
				alert('비밀번호가 일치하지 않습니다.');
				$j('#userPwCk').focus();
				
				return false;
			}
			

			if ($j('#userName').val() == '') {

				alert('이름을 입력해 주세요');
				$j('#userName').focus();

				return false;
			}

			if ($j('#userPhone2').val().length !=4 ) {

				alert('전화번호를 입력해 주세요');
				$j('#userPhone2').focus();

				return false;
			}

			if ($j('#userPhone3').val().length !=4 ) {

				alert('전화번호를 입력해 주세요');
				$j('#userPhone3').focus();

				return false;
			}

			if(addr1Check == 0 && $j("#userAddr1").length > 0){
				
				alert('우편번호 형식이 올바르지 않습니다.');
				$j('#userAddr1').focus();
				
				return false;
			}

			var $frm = $j('.userInsert :input');
			var param = $frm.serialize();
			
			$j.ajax({
				url : "/user/joinAction.do",
				dataType : "json",
				type : "POST",
				data : param,
				success : function(data, textStatus, jqXHR) {
					alert("회원가입완료");

					alert("메세지:" + data.success);

					location.href = "/user/login.do";
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert("실패");
				}
			});

		});
	});
</script>
<body>
	<form class="userInsert">
		<table align="center">
			<tr>
				<td align="left"><a href="/board/boardList.do">List</a></td>

			</tr>
			<tr>
				<td>
					<table border="1">
						<tr>
							<td width="100" align="center">id<font color="red">*</font></td>
							<td><input type="text" id="userId" name="userId" maxlength="15">
								<button type="button" id="checkBtn">중복확인</button>
								<p class="alertId alert-positive">
									<small style='color: black'></small>
								</p></td>
						</tr>
						<tr>
							<td align="center">pw<font color="red">*</font></td>
							<td><input type="password" id="userPw" name="userPw">
								<p class="alertPass alert-positive">
									<small style='color: black'>(6~12자리로 입력)</small>
								</p></td>
						</tr>
						<tr>
							<td align="center">pw check<font color="red">*</font></td>
							<td><input type="password" id="userPwCk" name="userPwCk">
								<p class="alertPass2 alert-positive">
									<small style='color: black'></small>
								</p></td>
						</tr>
						<tr>
							<td align="center">name<font color="red">*</font></td>
							<td><input type="text" id="userName" name="userName"
								maxlength="5">
								<p class="alertName alert-positive">
									<small style='color: black'></small>
								</p></td>
						</tr>
						<tr>
							<td align="center">phone<font color="red">*</font></td>
							<td><select id="phone" id="userPhone1" name="userPhone1">
									<c:forEach var="code" items="${codeNameList}">
										<option value="${code.codeId}">${code.codeName}</option>
									</c:forEach>
							</select> - <input type="tel" id="userPhone2" name="userPhone2"
								maxlength="4" size="2" pattern="[0-9]{4}" required> - <input
								type="tel" id="userPhone3" name="userPhone3" maxlength="4"
								size="2" pattern="[0-9]{4}" required>
								<p class="alertPhone alert-positive">
									<small style='color: black'></small>
								</p></td>
						</tr>
						<tr>
							<td align="center">postNo</td>
							<td><input type="tel" id="userAddr1" name="userAddr1"
								maxlength="7" pattern="[0-9]{3}-[0-9]{3}">
								<p class="alertAddr1 alert-positive">
									<small style='color: black'>000-000 형식으로 입력해주세요.</small>
								</p></td>
						</tr>
						<tr>
							<td align="center">address</td>
							<td><input type="text" id="userAddr2" name="userAddr2"
								maxlength="70"></td>
						</tr>
						<tr>
							<td align="center">company</td>
							<td><input type="text" id="userCompany" name="userCompany"
								maxlength="30"></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td align="right"><a href="#" id="joinBtn" class="text-dark">Join</a></td>
			</tr>
		</table>
	</form>
</body>
</html>
