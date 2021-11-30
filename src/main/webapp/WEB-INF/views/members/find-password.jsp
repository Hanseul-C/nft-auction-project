<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<title>비밀번호 찾기 페이지</title>
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
				<div class="card border-primary mt-5">
					<div class="card-body p-5">
						<h2 class="card-title">비밀번호 찾기</h2>
						<hr>
						<form action="" method="post">
							<div class="form-floating mb-3">
							<input type="text" class="form-control" id="floatId" name="memberId" placeholder="아이디 입력" required><br>
								<label for="floatId">아이디</label>
							</div>
							<div class="form-floating mb-3">
								<input type="text" class="form-control" id="floatEmail" name="memberEmail" placeholder="이메일 입력" required><br> 
								<label for="floatEmail">이메일</label>
							</div>
							<input type="submit" class="btn btn-outline-primary" value="발급하기">
						</form>
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
	<input type="hidden" id="email_result" value="${emailResult }">
	<input type="hidden" id="access" value="${accessResult }">
	<!-- JavaScript -->
	<script type="text/javascript">
		$(function(){
			confirmEmailResult();
			accessNonmember();
			
			function confirmEmailResult() {
				var result = $('#email_result').val();
				console.log(result);
				if(result=='fail'){
					alert('입력한 정보와 일치하는 회원이 없습니다.');
				}
			}//end confirmEmailResult()
			
			/* 로그인한 회원은 이용할 수 없음 */
			function accessNonmember() {
				var access=$('#access').val();
				if(access=='fail'){
					alert('로그인한 회원은 이용할 수 없습니다.');
					location.href='../main';
				}
			} //end accessNonmember()
		}); //end document	
	</script>
</body>
</html>