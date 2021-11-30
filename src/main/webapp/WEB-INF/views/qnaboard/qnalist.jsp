<%@page import="project.spring.nft.domain.QnABoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
table, th, td {
  border-style: solid;
  border-width: 1px;
  text-align: center;
}

ul {
  list-style-type: none;
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

<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<title>QnA List</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
  href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
  src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
  src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
  src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!-- 로그인한 아이디가 작성한 게시글만 볼 수 있도록 수정
       관리자는 전체 게시글 확인할 수 있도록 수정 해야됨 -->
</head>
<body>

  <!-- header -->
  <nav class="navbar navbar-expand-lg navbar-light bg-warning sticky-top">
    <a class="navbar-brand" href="../main">NFT-AUCTION</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse"
      data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown"
      aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNavDropdown">
      <ul class="navbar-nav ml-auto">
        <li class="nav-item"><a class="nav-link"
          href="../arts/register">작품등록</a></li>
        <c:if test="${empty sessionScope.memberId }">
          <li class="nav-item"><a class="nav-link"
            href="../members/login">로그인</a></li>
          <li class="nav-item"><a class="nav-link"
            href="../members/sign-up">회원가입</a></li>
        </c:if>
        <c:if test="${not empty sessionScope.memberId }">
          <li class="nav-item"><a class="nav-link"
            href="../members/logout">로그아웃</a></li>
          <li class="nav-item"><a class="nav-link"
            href="../members/my-page/member">마이페이지</a></li>
        </c:if>
      </ul>
    </div>
  </nav>
  <aside class="aside">
    <div id="page-wrapper">
      <!-- 사이드바 -->
      <div id="sidebar-wrapper">
        <ul class="sidebar-nav">
          <li class="sidebar-brand"><a href="../members/my-page/member">마이페이지</a></li>
          <li><a href="../members/my-page/member">회원정보</a></li>
          <li><a href="../wishlist/wishpage">위시리스트</a></li>
          <li><a href="../members/my-page/artlist">등록작품내역</a></li>
          <li><a href="../members/my-page/shopping-list">구매작품내역</a></li>
          <li><a href="../qnaboard/qnalist">QnA게시판</a></li>
        </ul>
      </div>
      <!-- /사이드바 -->
    </div>
  </aside>
	<section class="section">
		<div id="page-wrapper">
			<!-- 본문 헤더 -->
			<div id="page-content-wrapper">
				<div class="container-fluid">
					<h1>QnA List</h1>
					<hr>
				</div>
			</div>
			<div class="content m-3">

              <button type="button" class="btn btn-warning" onclick="location.href='qnaregister?memberId=<%=session.getAttribute("memberId")%>'">문의하기</button>
			  <!-- <button class="btn btn-primary"></button> -->
			  <div align="center">
			    <table class="table">
			      <tr class="table-warning">
			        <th scope="col" style="width: 10%">번호</th>
			        <th scope="col">제목</th>
			        <th scope="col" style="width: 20%">작성자</th>
			        <th scope="col" style="width: 20%">등록일</th>
			      </tr>
			      
			            <c:forEach items="${qnalist }" var="qnalist">
			        <tr>
			          <td><c:out value="${qnalist.qnaboardNo }" /></td>
			          <td><a href="qnadetail?qnaboardNo=${qnalist.qnaboardNo }&memberId=<%=session.getAttribute("memberId") %>"><c:out value="${qnalist.qnaboardTitle }" /></td>
			          <td><c:out value="${qnalist.memberNickname }" /></td>
			          <c:set var="qnaboardDate"><fmt:formatDate value="${qnalist.qnaboardDate }" pattern="YYYY-MM-dd hh:mm"/></c:set>
			          <td><c:out value="${qnaboardDate }"/></td>          
			        </tr>
			      </c:forEach>
			
			    </table>  
			  </div>
			  
			   <hr>
         <div>
  
</div>
			  <div align="center">
			  <ul class="pagination">
			    <c:if test="${pageMaker.hasPrev }">
			      <li class="page-item"><a class="page-link" href="qnalist?page=${pageMaker.startPageNo - 1 }">이전</a></li>
			    </c:if>
			    <c:forEach begin="${pageMaker.startPageNo }" 
			    end="${pageMaker.endPageNo }" var="num">
			      <li class="page-item"><a class="page-link" href="qnalist?page=${num }">${num }</a></li>   
			    </c:forEach>
			    <c:if test="${pageMaker.hasNext }">
			      <li class="page-item"><a class="page-link" href="qnalist?page=${pageMaker.endPageNo + 1 }">다음</a></li>
			    </c:if>
			  </ul>
			  </div>
			</div>
		</div>
	</section>
<<<<<<< HEAD
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
      </div>>
  
=======
  	<!-- footer -->
	<div class="mt-5 p-3 bg-light" style="bottom: 0;">
		<h4>NFT-AUCTION</h4>
		<hr>
		<div class="p-3">
		<a href="#">이용약관</a> &nbsp;
		<a href="#">사이트안내</a>
		<br><br>
		<small>문의 nftauction_admin@gmail.com</small>
		</div>
	</div>
>>>>>>> origin/develop-yed
  <script type="text/javascript">
    $(document).ready(function() {
        // 로그인 버튼 클릭
        $('#btn_login').click(function() {
            location = '../members/login';
        }); // end btn_login.click()
        
        // 로그아웃 버튼 클릭
        $('#btn_logout').click(function() {
            location = '../members/login';
        }); // end btn_logout.click()
    }); // end document()
  </script>

</body>
</html>