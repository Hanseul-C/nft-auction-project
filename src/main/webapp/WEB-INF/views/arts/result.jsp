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
<title>결제 결과</title>
</head>
<body>
  <br>
  <h4>결제가 완료되었습니다.</h4><br>
  <div align="center">
    <div>
      <ul class="list-group list-group-horizontal justify-content-center" >
       <li class="list-group-item list-group-item-primary" style="width: 10rem">주문 번호</li>
       <li class="list-group-item" style="width: 30rem">${vo.merchantUid }</li>
      </ul>
      <ul class="list-group list-group-horizontal justify-content-center" >
       <li class="list-group-item list-group-item-primary" style="width: 10rem">아이디</li>
       <li class="list-group-item" style="width: 30rem">${vo.memberId }</li>
      </ul>
      <ul class="list-group list-group-horizontal justify-content-center">
       <li class="list-group-item list-group-item-primary" style="width: 10rem">작품 가격</li>
       <li class="list-group-item" style="width: 30rem">${vo.artPrice }</li>
      </ul>
      <ul class="list-group list-group-horizontal justify-content-center">
        <li class="list-group-item list-group-item-primary" style="width: 10rem">작품 이름</li>
        <li class="list-group-item" style="width: 30rem">${vo.artName }</li>
      </ul>
      <ul class="list-group list-group-horizontal justify-content-center">
        <li class="list-group-item list-group-item-primary" style="width: 10rem">작품 번호</li>
        <li class="list-group-item" style="width: 30rem">${vo.artNo }</li>
      </ul>
      <ul class="list-group list-group-horizontal justify-content-center">
        <li class="list-group-item list-group-item-primary" style="width: 10rem">파일 이름</li>
        <li class="list-group-item" style="width: 30rem">${vo.artFileName }</li>
      </ul>
    </div>    
    <br>
      <button type="button" class="btn btn-primary" onclick= "myPage()">마이페이지</button>
      <button type="button" class="btn btn-primary" onclick= "main()">메인</button>
      <button type="button" class="btn btn-primary" onclick="window.close()">창닫기</button>
  </div>
  
  <script type="text/javascript">

	function myPage() {
	    opener.parent.location='../members/my-page/member'; 
    	window.close(); 
    }  			    
  
    function main() {
        opener.parent.location='../main'; 
        window.close(); 
    } 
      
  </script>
  
</body>
</html>