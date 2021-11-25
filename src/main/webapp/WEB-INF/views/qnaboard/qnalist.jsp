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

li {
  display: inline-block;
}
</style>

<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<title>QnA List</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!-- 로그인한 아이디가 작성한 게시글만 볼 수 있도록 수정
       관리자는 전체 게시글 확인할 수 있도록 수정 해야됨 -->
</head>
<body>
<!-- header -->
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
    <a class="navbar-brand" href="../main">NFT-AUCTION</a>
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
  </nav>
  <h1>QnA List</h1>
  <hr>
  <c:if test="${empty sessionScope.memberId }">
    <button type="button" id="btn_login" class="btn btn-primary">로그인</button>
  </c:if>
  <c:if test="${not empty sessionScope.memberId }">
    <button type="button" id="btn_logout" class="btn btn-primary">로그아웃</button>
  </c:if>
  <a href="qnaregister">문의하기</a>
  <!-- <button class="btn btn-primary"></button> -->
  <div align="center">
    <table class="table table-bordered" style="width: 50%">
      <tr>
        <th scope="col" style="width: 10%">번호</th>
        <th scope="col">제목</th>
        <th scope="col" style="width: 20%">작성자</th>
        <th scope="col" style="width: 20%">등록일</th>
      </tr>
      
            <c:forEach items="${qnalist }" var="qnalist">
        <tr>
          <td><c:out value="${qnalist.qnaboardNo }" /></td>
          <td><a href="qnadetail?qnaboardNo=${qnalist.qnaboardNo }" ><c:out value="${qnalist.qnaboardTitle }" /></a></td>
          <td><c:out value="${qnalist.memberNickname }" /></td>
          <c:set var="qnaboardDate"><fmt:formatDate value="${qnalist.qnaboardDate }" pattern="YYYY-MM-dd hh:mm"/></c:set>
          <td><c:out value="${qnaboardDate }"/></td>          
        </tr>
      </c:forEach>

    </table>  
  </div>
  
   <hr>
  <div align="center">
  <ul>
    <c:if test="${pageMaker.hasPrev }">
      <li><a href="qnalist?page=${pageMaker.startPageNo - 1 }">이전</a></li>
    </c:if>
    <c:forEach begin="${pageMaker.startPageNo }" 
    end="${pageMaker.endPageNo }" var="num">
      <li><a href="qnalist?page=${num }">${num }</a></li>   
    </c:forEach>
    <c:if test="${pageMaker.hasNext }">
      <li><a href="qnalist?page=${pageMaker.endPageNo + 1 }">다음</a></li>
    </c:if>
  </ul>
  </div>
  
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