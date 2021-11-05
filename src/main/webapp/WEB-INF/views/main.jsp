<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 모바일 디바이스에서 터치/줌 등을 지원하기 위한 meta 태그 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<!-- Popper JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<!-- css -->
<style type="text/css">
img {
	max-width: 100%;
	height: auto;
}

ul {
	list-style-type: none;
}

li {
	display: inline-block;
}
</style>
<title>메인 페이지</title>
<script type="text/javascript">
</script>
</head>
<body style="text-align: center;">
	<!-- header -->
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
		<div class="container-fluid">
			<a class="navbar-brand" href="main">NTF-AUCTION</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarColor02"
				aria-controls="navbarColor02" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarColor02">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item"><a class="nav-link" href="arts/register">작품등록</a>
					</li>
					<c:if test="${empty sessionScope.memberId }">
						<li class="nav-item"><a class="nav-link" href="members/login">로그인</a>
						</li>
						<li class="nav-item"><a class="nav-link"
							href="members/sign-up">회원가입</a></li>
					</c:if>
					<c:if test="${not empty sessionScope.memberId }">
						<li class="nav-item"><a class="nav-link"
							href="members/logout">로그아웃</a></li>
						<li class="nav-item"><a class="nav-link"
							href="members/my-page/member">마이페이지</a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</nav>
	<!-- 검색 -->
	<br>
	<div class="search">
		<input type="radio" name="category" value="artName" checked>작품명
		<input type="radio" name="category" value="memberNickname">작가명
		<input type="text" id="keyword" placeholder="검색어 입력">
		<a href="search&"><button type="button" class="btn btn-primary">검색</button></a>
	</div>
	<br>
	<div class="container">
		<!-- 정렬 기준 -->
		<div class="row">
			<div class="col-sm-8"></div>
			<div class="col-sm-4">
				<a href="cur"><button type="button" class="btn">등록순</button></a>
				<a href="wish"><button type="button" class="btn">찜하기순</button></a>
				<a href="view"><button type="button" class="btn">조회수순</button></a>
			</div>
		</div>
		<br>
		<!-- 작품 목록 -->
		<div class="row">
			<c:forEach var="vo" items="${list }">
				<div class="col-sm-4">
					<div class="card border-primary mb-3" style="max-width: 20rem;">
						<div class="card-header">by ${vo.memberNickname} </div>
						<div class="card-body">
							<h4 class="card-title">
								<img src="/nft-auction/arts/display?fileName=${vo.artFileName }"></h4>
							<hr>
							<p class="card-text">${vo.artName }
							<button type="button" class="btn float-right">찜수 ${vo.artWishCount}</button></p>
						</div>
					</div>
				</div>			
			</c:forEach>
		</div>
	</div>
	<!-- 페이징처리 -->
	<div id="paging">
		<ul class="pagination justify-content-center">
			<c:if test="${pageMaker.hasPrev }">
				<li><a href="?page=${pageMaker.startPageNo-1 }">&laquo;</a></li>
			</c:if>
			<c:forEach begin="${pageMaker.startPageNo }" end="${pageMaker.endPageNo }" var="num">
 				<li class="page-item">
					<a class="page-link" href="?page=${num }">${num }</a>
					<input type="hidden" class="page-num" value="${num }">
				</li>
			</c:forEach>
			<c:if test="${pageMaker.hasNext }">
				<li><a href="?page=${pageMaker.endPageNo+1 }">&raquo;</a></li>
			</c:if>
		</ul>
	</div>
	<input type="hidden" id="login_result" value="${loginResult }">
	<input type="hidden" id="logout_result" value="${logoutResult }">
	<input type="hidden" id="join_result" value="${joinResult }">
	<input type="hidden" id="register_result" value="${registerResult }">
	<!-- footer -->
	<div class="jumbotron text-center mt-5 mb-0">
		<h4>NFT-AUCTION</h4>
		<p>이용약관 고객센터..주소..어쩌구</p>
	</div>
	<!-- JavaScript -->
	<script type="text/javascript">		
		$(function(){
			pageAction();
			/* 동작 수행 완료 alert */
	  		confirmLoginResult();
	  		confirmLogoutResult();
	  		confirmJoinResult();
	  		confirmRegisterResult();
	  		
			function confirmLoginResult() {
				var result=$('#login_result').val();
				if(result=='success'){
					alert('로그인 성공');
				}
			}//end confirmLoginRslut()
			
			function confirmLogoutResult() {
				var result=$('#logout_result').val();
				if(result=='success'){
					alert('로그아웃 성공');
				}
			}//end confirmLogoutResult()
			
			function confirmJoinResult() {
				var result=$('#join_result').val();
				if(result=='success'){
					alert('회원가입 성공');
				}
			}//end confirmJoinResult()
			
			function confirmRegisterResult() {
				var result=$('#register_result').val();
				if(result=='success'){
					alert('작품 등록 성공');
				}
			}//end confirmRegisterResult()
			
			/* 정렬 */
			$('#current_list').click(function(){
				$('#wish_list').removeClass('btn-primary');
				$('#view_list').removeClass('btn-primary');
				$(this).addClass('btn-primary'); //클릭된 버튼
				currentAllList();
			}); //end current_list click()

			$('#wish_list').click(function(){
				$('#current_list').removeClass('btn-primary');
				$('#view_list').removeClass('btn-primary');
				$(this).addClass('btn-primary'); //클릭된 버튼
				wishAllList();
			}); //end wish_list click()

			$('#view_list').click(function(){
				$('#current_list').removeClass('btn-primary');
				$('#wish_list').removeClass('btn-primary');
				$(this).addClass('btn-primary'); //클릭된 버튼
				viewAllList();
			}); //end view_list click()
			
		}); //end document
		
		/* 현재 페이지네이션 표시 */
		function pageAction() {
			var url = $(location).attr('search'); //쿼리스트링
			var page_num=url.charAt(url.length-1);
			console.log(page_num);
			
			$('input[class=page-num]').each(function(x){
				console.log(x);
				
				if(!url && (x+1)==1){
					$(this).parents('.page-item').last().addClass('active');
				}
				if(page_num == (x+1)){
					console.log($(this).parents('.page-item').last());
					$(this).parents('.page-item').last().addClass('active');
				}
			})
		}
	</script>
</body>
</html>