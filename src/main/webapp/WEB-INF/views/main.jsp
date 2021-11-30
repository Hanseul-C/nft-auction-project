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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/js/bootstrap.bundle.min.js"></script>
<!-- Popper JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<!-- CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@5.1.3/dist/zephyr/bootstrap.min.css">
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

<<<<<<< HEAD
/* 사이드바 래퍼 스타일 */
#page-wrapper {
  padding-right: 250px;
}
#sidebar-wrapper {
  position: fixed;
  width: 350px;
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
  width: 350px;
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

.carousel-indicators {
  position: absolute;
  right: 0;
  bottom: 10px;
  left: 0;
  z-index: 15;
  display: flex;
  justify-content: center;
  padding-left: 0; // override <ol> default
  // Use the .carousel-control's width as margin so we don't overlay those
  margin-right: $carousel-control-width;
  margin-left: $carousel-control-width;
  list-style: none;

  li {
    position: relative;
    flex: 0 1 auto;
    width: $carousel-indicator-width;
    height: $carousel-indicator-height;
    margin-right: $carousel-indicator-spacer;
    margin-left: $carousel-indicator-spacer;
    text-indent: -999px;
    cursor: pointer;
    background-color: rgba($carousel-indicator-active-bg, .5);

    // Use pseudo classes to increase the hit area by 10px on top and bottom.
    &::before {
      position: absolute;
      top: -10px;
      left: 0;
      display: inline-block;
      width: 100%;
      height: 10px;
      content: "";
    }
    &::after {
      position: absolute;
      bottom: -10px;
      left: 0;
      display: inline-block;
      width: 100%;
      height: 10px;
      content: "";
    }
  }

  .active {
    background-color: $carousel-indicator-active-bg;
  }
}
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
=======
>>>>>>> origin/develop-yed
</style>
<title>메인 페이지</title>
<script type="text/javascript">
</script>
</head>
<body style="text-align: center;">
	<!-- header -->
	<nav class="navbar navbar-expand-lg navbar-light bg-warning sticky-top">
		<div class="container-fluid">
			<a class="navbar-brand" href="main">NFT-AUCTION</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNavDropdown">
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
						<li class="nav-item"><a class="nav-link" href="members/logout">로그아웃</a></li>
						<li class="nav-item"><a class="nav-link"
							href="members/my-page/member">마이페이지</a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</nav>
 <aside class="aside">
    <div id="page-wrapper">  
      <div id="sidebar-wrapper">
        <iframe src="arts/auctionRT" height="900">
        </iframe>
      </div>
      <!-- /사이드바 -->
    </div>
  </aside>
<div class="example-container">
  <div class="example-row">
    <div class="example-content-main">
    
	<!-- 낙찰 alert -->
	<c:if test="${not empty sessionScope.memberId }">
		<div id="bid_alert">
		</div>
	</c:if>
	<!-- 검색 -->
	<br>
	<div class="search m-3">
		<form action="search" method="get">
			<input type="radio" name="category" value="artName" checked>작품명
			<input type="radio" name="category" value="memberNickname">작가명
			<input type="text" id="keyword" name="keyword" placeholder="검색어 입력">
			<input type="submit" class="btn btn-primary" value="검색">
		</form>
	</div>
	<br>
	<!-- 전체 작품 리스트 -->
	<div class="container justify-content-center">
		<!-- 정렬 기준 -->
		<div class="row justify-content-center mb-3">
			<div class="col-sm-8"></div>
			<div class="col-sm-4">
				<a href="cur"><button type="button" class="btn btn-outline-primary">등록순</button></a>
				<a href="wish"><button type="button" class="btn btn-outline-primary">찜하기순</button></a>
				<a href="view"><button type="button" class="btn btn-outline-primary">조회수순</button></a>
			</div>
		</div>
		<br>
		<!-- 작품 목록 -->
		<div class="row justify-content-center m-3">
			<c:forEach var="vo" items="${list }">
				<div class="col-sm-4 justify-content-center">
					<div class="card border-primary mb-3">
						<div class="card-header">by ${vo.memberNickname} </div>
						<div class="card-body">
							<a href="arts/detail?artNo=${vo.artNo}&page=${pageMaker.criteria.page}">
								<h4 class="card-title">
								<img src="/nft-auction/arts/display?fileName=${vo.artFileName }"></h4>
								<hr>
								<p class="card-text">${vo.artName }</p>
							</a>
							<span class="float-right">찜수 ${vo.artWishCount}</span>
						</div>
					</div>
				</div>			
			</c:forEach>
		</div>
<<<<<<< HEAD
	</div>  
  
	<!-- 페이징처리 -->
	<div id="paging">
=======
		<!-- 페이징처리 -->
		<div id="paging" class="m-5">
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
>>>>>>> origin/develop-yed
	</div>
	<!-- hidden -->
	<input type="hidden" id="hasPrev" value="${pageMaker.hasPrev }">
	<input type="hidden" id="startPageNo" value="${pageMaker.startPageNo }">
	<input type="hidden" id="endPageNo" value="${pageMaker.endPageNo }">
	<input type="hidden" id="hasNext" value="${pageMaker.hasNext }">
	<input type="hidden" id="login_result" value="${loginResult }">
	<input type="hidden" id="logout_result" value="${logoutResult }">
	<input type="hidden" id="join_result" value="${joinResult }">
	<input type="hidden" id="register_result" value="${registerResult }">
	<input type="hidden" id="member_id" value="${sessionScope.memberId }">
<<<<<<< HEAD
  </div>
  
 </div>
</div>
	<!-- footer -->
	<footer class="bd-footer py-5 mt-5 bg-secondary sticky-bottom">
		<div class="container py-5">
			<h4>NFT-AUCTION</h4>
			<p>이용약관 고객센터..주소..어쩌구</p>
		</div>
	</footer>
=======
	<input type="hidden" id="delete_result" value="${deleteResult }">
>>>>>>> origin/develop-yed
	<!-- JavaScript -->
	<script type="text/javascript">		
		$(function(){
			showPagination();
			winningBid();
			/* 동작 수행 완료 alert */
	  		confirmLoginResult();
	  		confirmLogoutResult();
	  		confirmJoinResult();
	  		confirmRegisterResult();
	  		confirmDeleteResult();
	  		
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
			
			function confirmDeleteResult() {
				var result=$('#delete_result').val();
				if(result=='success'){
					alert('작품 삭제 성공');
				}else if(result=='fail'){
					alert('작성자만 삭제할 수 있습니다.');
				}
			} //end confirmDeleteResult()
			
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
				
				if(!URLSearch.get('page')){
					if((x+1)==1){
						$(this).parents('.page-item').last().addClass('active');
					}
				}else{
					if(page_num == (x+1)){
						console.log($(this).parents('.page-item').last());
						$(this).parents('.page-item').last().addClass('active');
					}
				}
			})
		}//end pageAction()
		
		/* 회원 낙찰 소식 알림 */
		function winningBid() {
			var member_id=$('#member_id').val();
			console.log(member_id);
			$.ajax({
				type:'post',
				url:'arts/winning',
				data:{
					memberId:member_id
				},
				success:function(resultData){
					console.log(resultData);
					var list='';
					$(resultData).each(function(){
						list+='<div class="alert alert-primary alert-dismissible m-0 fade show" role="alert">'
							+'<button type="button" class="btn-close" data-bs-dismiss="alert"></button>'
							+'<strong>'+member_id+'님</strong> ['
							+this.artName+']작품이 낙찰됐습니다. 결제를 진행하세요. '
							+'<a href="arts/detail?artNo='+this.artNo+'">'
							+'<button class="btn btn-outline-primary btn-sm">작품으로 이동</button></a>'
							+'</div>';
					}); //end each
					$('#bid_alert').html(list);
				}
			})
		} //end winningBid()
	</script>
</body>
</html>