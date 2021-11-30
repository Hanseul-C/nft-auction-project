<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<style type="text/css">
/* 헤더 스타일 */
img {
	max-width: 100%;
	height: auto;
}
/* 사이드바 래퍼 스타일 */
#page-wrapper {
	padding-left: 250px;
}
#sidebar-wrapper {
	position: fixed;
	width: 250px;
	height: 100%;
	margin-left: -250px;
	background: #000;
	overflow-x: hidden;
	overflow-y: auto;
}
#page-content-wrapper {
	width: 100%;
	padding: 20px;
}
/* 사이드바 스타일 */
.sidebar-nav {
	width: 250px;
	margin: 0;
	padding: 0;
	list-style: none;
}
.sidebar-nav li {
	text-indent: 1.5em;
	line-height: 2.8em;
}
.sidebar-nav li a {
	display: block;
	text-decoration: none;
	color: #999;
}
.sidebar-nav li a:hover {
	color: #fff;
	background: rgba(255, 255, 255, 0.2);
}
.sidebar-nav>.sidebar-brand {
	font-size: 1.3em;
	line-height: 3em;
}
.aside {
	width: 30%;
	align: left;
}
</style>
</head>
<body>
	<!-- header -->
	<nav class="navbar navbar-expand-lg navbar-light bg-warning sticky-top">
		<div class="container-fluid">
			<a class="navbar-brand" href="../../main">NTF-AUCTION</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNavDropdown">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item"><a class="nav-link"
						href="../../arts/register">작품등록</a></li>
					<c:if test="${empty sessionScope.memberId }">
						<li class="nav-item"><a class="nav-link" href="../login">로그인</a></li>
						<li class="nav-item"><a class="nav-link" href="../sign-up">회원가입</a></li>
					</c:if>
					<c:if test="${not empty sessionScope.memberId }">
						<li class="nav-item"><a class="nav-link" href="../logout">로그아웃</a></li>
						<li class="nav-item"><a class="nav-link" href="member">마이페이지</a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</nav>
	<aside class="aside">
		<div id="page-wrapper">
			<!-- 사이드바 -->
			<div id="sidebar-wrapper">
				<ul class="sidebar-nav">
					<li class="sidebar-brand"><a href="member">마이페이지</a></li>
					<li><a href="member">회원정보</a></li>
					<li><a href="../../wishlist/wishpage">위시리스트</a></li>
					<li><a href="artlist">등록작품내역</a></li>
					<li><a href="shopping-list">구매작품내역</a></li>
					<li><a href="../../qnaboard/qnalist">QnA게시판</a></li>
				</ul>
			</div>
			<!-- /사이드바 -->
		</div>
	</aside>
	<section class="section" style="text-align: center;">
		<div id="page-wrapper">
			<!-- 본문 헤더 -->
			<div id="page-content-wrapper" style="text-align: left;">
				<div class="container-fluid mt-3">
					<h1>등록 작품 내역</h1>
					<hr>
				</div>
			</div>
			<div class="content m-3" style="padding-bottom: 200px">
				<!-- 등록한 작품 내역 리스트 보여주기!!! -->
				<div class="row">
					<c:if test="${not empty list }">
						<c:forEach var="vo" items="${list }">
							<div class="col-sm-4">
								<div class="card border-primary mb-3" style="max-width: 20rem;">
									<div class="card-header">by ${vo.memberId}</div>
									<div class="card-body">
										<a
											href="../../arts/detail?artNo=${vo.artNo}&page=${pageMaker.criteria.page}">
											<h4 class="card-title">
												<img
													src="/nft-auction/arts/display?fileName=${vo.artFileName }">
											</h4>
											<hr>
											<p class="card-text">${vo.artName }</p>
											
										</a>
									</div>
								</div>
							</div>
						</c:forEach>
					</c:if>
				</div>
				<!-- 페이징처리 -->
				<div id="paging" class="mt-3">
				</div>
				<!-- 정산 -->
				<div class="row mt-5" style="text-align: left;">
					<div class="col m-3">
						<h2>정산 받기</h2>
						<hr>
						<div class="m-5">
							<p><strong>${sessionScope.memberId }님</strong>의 
							현재 정산 가능한 금액은 
							<span style="font-size: 1.3em;">
							<fmt:formatNumber value="${profit }" type="currency"
										currencySymbol="" /></span>원
							 입니다. <small style="color: grey;">(수수료 5% 제외)</small></p>
							<button type="button" id="btn-refund" class="btn btn-outline-primary popover-test">정산하기</button>
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
		</div>
	</section>
	
	<!-- hidden -->
	<input type="hidden" id="hasPrev" value="${pageMaker.hasPrev }">
	<input type="hidden" id="startPageNo" value="${pageMaker.startPageNo }">
	<input type="hidden" id="endPageNo" value="${pageMaker.endPageNo }">
	<input type="hidden" id="hasNext" value="${pageMaker.hasNext }">
	<input type="hidden" id="profit" value="${profit }">
	<!-- JavaScript -->
	<script type="text/javascript">
		showPagination();
		
		/* 페이지네이션 */
		function showPagination() {
			var hasPrev=$('#hasPrev').val();
			var hasNext=$('#hasNext').val();
			var startPageNo=$('#startPageNo').val();
			var endPageNo=$('#endPageNo').val();
			console.log(hasPrev+', '+hasNext+', '+startPageNo+', '+endPageNo);
			
			var paging='';
			var prev='disabled';
			var next='disabled';
			var start='';
			var end='';
			if(hasPrev == "true"){ // hasPrev/Next가 문자열이라
				prev='';
			}
			if(hasNext == "true"){
				next='';
			}
			
			var queryString=$(location).attr('search');
			queryString=queryString.replace('?','');
			var URLSearch = new URLSearchParams(location.search);
			var url = '';
			console.log(URLSearch);
			
			//url 쿼리스트링연결
			if(!queryString){
				start = 'page='+ (startPageNo-1);
				end = 'page='+ (parseInt(endPageNo)+1);
			}else{
				if(URLSearch.get('page') != null){ //page 쿼리스트링이 있으면
					URLSearch.set('page', (startPageNo-1));
					start=URLSearch.toString();
					URLSearch.set('page', (parseInt(endPageNo)+1));
					end=URLSearch.toString();
					console.log(start+', '+end);
				}else{
					start = queryString+'&page='+(startPageNo-1);	
					end = queryString+'&page='+(parseInt(endPageNo)+1);	
					console.log(start+', '+end)
				}
			}
						
			paging+='<ul class="pagination justify-content-center">'
				+'<li class="page-item '+prev+'">'
				+'<a class="page-link" href="?'+start+'">&laquo;</a></li>';
			
			for (var i = startPageNo; i <= endPageNo; i++) {
				if(!queryString){ 
					url='page='+i;						
				}else{ //쿼리스트링이 있으면
					if(URLSearch.get('page') != null){ //page 쿼리스트링이 있으면
						URLSearch.set('page', i);
						url=URLSearch.toString();
					}else{
						url=queryString+'&page='+i;						
					}
				}
				console.log(url);				
				
				paging+='<li class="page-item">'
					+'<a class="page-link" href="?'+url+'">'+i+'</a>'
					+'<input type="hidden" class="page-num" value="'+i+'">'
					+'</li>';
			}
			
			paging+='<li class="page-item '+next+'">'
				+'<a class="page-link" href="?'+end+'">&raquo;</a></li>'
				+'</ul>';
			
			$('#paging').html(paging);
			pageAction();
		} //end showPagination()
		
		/* 현재 페이지네이션 표시 */
		function pageAction() {
			var url = $(location).attr('search'); //쿼리스트링
			var URLSearch = new URLSearchParams(location.search);
			var page_num=url.charAt(url.length-1);
			console.log(page_num);
			
			$('input[class=page-num]').each(function(x){
				console.log(x);
				
				if(!URLSearch.get('page') && (x+1)==1){
					$(this).parents('.page-item').last().addClass('active');
				}
				if(page_num == (x+1)){
					console.log($(this).parents('.page-item').last());
					$(this).parents('.page-item').last().addClass('active');
				}
			})
		}//end pageAction()
		
		$('#btn-refund').click(function(){
			var profit=$('#profit').val();
			
			if(profit ==0){
				alert('정산받을 수 있는 환급액이 없습니다.');
			}else{
				window.open('refund', 'PopupWin','width=900, height=800, resizable=no');
			}
		}); //end btn-refund click
		
    </script>

</body>
</html>