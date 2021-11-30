<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<!-- 모바일 디바이스에서 터치/줌 등을 지원하기 위한 meta 태그 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous"> -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<!-- Popper JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<!-- CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@5.1.3/dist/zephyr/bootstrap.min.css">
<title>아이디 찾기 페이지</title>
<!-- JavaScript -->
<script type="text/javascript">
	$(function() {
		/* 전화번호 형식적용 */
		$('#member_phone').keyup(function() {
			var member_phone = $('#member_phone').val();
			console.log(member_phone);
			//'-' 입력 막기
			member_phone = member_phone.replace(/[^0-9]/g, '');
			//전화번호 '-' 자동 삽입
			var regPhone = member_phone.replace(
					/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,
					"$1-$2-$3")
			$('#member_phone').val(regPhone);
		}); //end member_phone keyup()		
	}); //end document
	
	/* 전화번호로 찾기 버튼 활성화 */
	function submitPhone() {
		var phone=$('#member_phone').val();
		console.log(phone);
		//전화번호 정규표현식 적용
		var phone_check=
			/^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
		//phone=phone.replace(/(.{3,4})/g,'-');
		
		if(phone_check.test(phone) === false){
			alert('올바른 전화번호 형식을 입력해주세요.');
			return false;
		}
		return true;
	}//end submitPhone()
	
	/* 이메일로 찾기 버튼 활성화 */
	function submitEmail() {
		var email=$('#member_email').val();
		console.log(email);
		//전화번호 정규표현식 적용
		var email_check=
		/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;

		
		if (email_check.test(email) === false) {
	    	alert('올바른 이메일 형식을 입력해주세요.');
	    	return false;
	    }
		return true;
	}//end submitEmail()
</script>
</head>
<body style="text-align: center;">
	<!-- header -->
	<nav class="navbar navbar-expand-lg navbar-light bg-warning sticky-top">
		<div class="container-fluid">
			<a class="navbar-brand" href="../main">NFT-AUCTION</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNavDropdown">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item"><a class="nav-link" href="../arts/register">작품등록</a>
					</li>
					<li class="nav-item"><a class="nav-link" href="login">로그인</a>
					</li>
					<li class="nav-item"><a class="nav-link"
						href="sign-up">회원가입</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<!-- body -->
	<div class="container" style="padding-bottom: 200px">
		<div class="row justify-content-center">
			<div class="col-sm-6 m-3">
				<div class="card border-primary">
					<div class="card-body p-5">
						<h5 class="card-title">등록된 휴대폰번호로 아이디 찾기</h5>
						<hr>
						<div class="card-text">
							<form action="find-id/phone" method="post" onsubmit="return submitPhone();">
								<div class="form-floating mb-3">
									<input type="text" class="form-control" id="floatName" name="memberName" placeholder="이름 입력" required><br>
									<label for="floatName">이름</label>
								</div>
								<div class="form-floating mb-3">
									<input type="text" class="form-control" id="member_phone" name="memberPhone" placeholder="전화번호 입력" required><br>
									<label for="member_phone">전화번호</label>
								</div>
								<input type="submit" class="btn btn-outline-primary" value="찾기">							
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row justify-content-center">
			<div class="col-sm-6 m-3">
				<div class="card border-primary">
					<div class="card-body p-5">
						<h5 class="card-title">등록된 이메일로 아이디 찾기</h5>
						<hr>
						<div class="card-text">
							<form action="find-id/email" method="post" onsubmit="return submitEmail();">
								<div class="form-floating mb-3">
									<input type="text" class="form-control" id="floatName2" name="memberName" placeholder="이름 입력" required><br>
									<label for="floatName2">이름</label>
								</div>
								<div class="form-floating mb-3">
									<input type="text" class="form-control" id="member_email" name="memberEmail" placeholder="이메일 입력" required><br>
									<label for="member_email">이메일</label>
								</div>
								<input type="submit" class="btn btn-outline-primary" value="찾기">							
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- footer -->
	<div class="mt-5 p-3 bg-light">
		<div style="bottom: 0; height: 200px;">
			<h4>NFT-AUCTION</h4>
			<hr>
			<br>
			<a href="#">이용약관</a> &nbsp;
			<a href="#">사이트안내</a>
			<br><br>
			<small>문의 nftauction_admin@gmail.com</small>
		</div>
	</div>
	<!-- hidden -->
	<input type="hidden" id="access" value="${accessResult }">
	<!-- JavaScript -->
	<script type="text/javascript">
		accessNonmember();	
	
		/* 로그인한 회원은 이용할 수 없음 */
		function accessNonmember() {
			var access=$('#access').val();
			if(access=='fail'){
				alert('로그인한 회원은 이용할 수 없습니다.');
				location.href='../main';
			}
		} //end accessNonmember()
	</script>
</body>
</html>