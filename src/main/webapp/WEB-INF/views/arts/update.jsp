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
<title>작품 수정 페이지</title>
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
					<li class="nav-item"><a class="nav-link" href="register">작품등록</a>
					</li>
					<c:if test="${empty sessionScope.memberId }">
						<li class="nav-item"><a class="nav-link" href="../members/login">로그인</a>
						</li>
						<li class="nav-item"><a class="nav-link"
							href="/members/sign-up">회원가입</a></li>
					</c:if>
					<c:if test="${not empty sessionScope.memberId }">
						<li class="nav-item"><a class="nav-link" href="../members/logout">로그아웃</a></li>
						<li class="nav-item"><a class="nav-link"
							href="../members/my-page/member">마이페이지</a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</nav>
	<br>
	<!-- content -->
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-sm-8">
				<h2 class="pt-3">작품 수정 페이지</h2>
				<hr>
				<div class="p-5">
					<form method="post">
						<input type="hidden" name="memberId" value="${sessionScope.memberId }">
						작품명<br>
						<input type="text" class="form-control" name="artName" value="${vo.artName }" required><br>
						즉시 판매가<br>
						<input type="number" class="form-control" name="artPrice" value="${vo.artPrice }" required><br>
						작품 설명<br>
						<input type="text" class="form-control" name="artContent" value="${vo.artContent }" required><br>
						작품 게시기간 설정<br>
						<input type="datetime-local" class="form-control" name="artShowDate" value="${vo.artShowDate }" required><br>
						경매시작금<br>
						<input type="number" class="form-control" name="artBasicFee" value="${vo.artBasicFee }" required><br>
						<div class="d-grid gap-2 mt-4">
							<input type="submit" class="btn btn-primary rounded-pill" value="수정하기">
						</div>
					</form>
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
	<input type="hidden" id="access" value="${access }">
	<!-- JavaScript -->
	<script type="text/javascript">
		accessId();
		
		function accessId() {
			var access=$('#access').val();
			if(access=='fail'){
				alert('작성자만 이용할 수 있습니다.');
				location.href='../main';
			}
		} //end accessId()
	</script>
</body>
</html>