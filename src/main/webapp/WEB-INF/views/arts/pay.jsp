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
  <!-- iamport.payment.js -->
  <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>
<title>결제 팝업창</title>
<style type="text/css">
img {
	max-width: 100%;
	height: auto;
}
</style>
</head>
<body>
<div align="center">
  <br>
  <h4>확인 후 결제하기를 눌러주세요</h4><br>
  <div class="card" style="width: 18rem;">
    <div id="image"></div>
  <div class="card-body" align="center">
    <p class="card-text">${avo.artName }</p>
    <p class="card-text">by ${avo.memberNickname }</p>
  </div>
</div>
<br>
<div>
<ul class="list-group list-group-horizontal justify-content-center" >
  <li class="list-group-item list-group-item-primary" style="width: 10rem">아이디</li>
  <li class="list-group-item" style="width: 30rem">${vo.memberId }</li>
</ul>
<ul class="list-group list-group-horizontal justify-content-center">
  <li class="list-group-item list-group-item-primary" style="width: 10rem">이름</li>
  <li class="list-group-item" style="width: 30rem">${vo.memberName }</li>
</ul>
<ul class="list-group list-group-horizontal justify-content-center">
  <li class="list-group-item list-group-item-primary" style="width: 10rem">연락처</li>
  <li class="list-group-item" style="width: 30rem">${vo.memberPhone }</li>
</ul>
<ul class="list-group list-group-horizontal justify-content-center">
  <li class="list-group-item list-group-item-primary" style="width: 10rem">이메일</li>
  <li class="list-group-item" style="width: 30rem">${vo.memberEmail }</li>
</ul>
<ul class="list-group list-group-horizontal justify-content-center">
  <li class="list-group-item list-group-item-primary" style="width: 10rem">작품 가격</li>
  <c:if test="${empty auvo }">
	  <li class="list-group-item" style="width: 30rem">${avo.artPrice }</li>
  </c:if>
  <c:if test="${not empty auvo }">
  	  <li class="list-group-item" style="width: 30rem">${auvo.auctionMoney }</li>
  </c:if>
</ul>
<ul class="list-group list-group-horizontal justify-content-center">
  <li class="list-group-item list-group-item-primary" style="width: 10rem">작품 번호</li>
  <li class="list-group-item" style="width: 30rem">${avo.artNo }</li>
</ul>
</div>

<br>
<button type="button" class="btn btn-primary" onclick= "requestPay()">결제하기</button>
<button type="button" class="btn btn-primary" onclick="window.close()">창닫기</button>
</div>

<input type="hidden" id="show_img" value="${avo.artFileName }">
<input type="hidden" id="memberName" value="${vo.memberName }">
<input type="hidden" id="memberPhone" value="${vo.memberPhone }"> 
<input type="hidden" id="memberEmail" value="${vo.memberEmail }">
<input type="hidden" id="artNo" value="${avo.artNo }">
<input type="hidden" id="artName" value="${avo.artName }">
<input type="hidden" id="artPrice" value="${avo.artPrice }">
<input type="hidden" id="memberId" value="${vo.memberId }"> 
<input type="hidden" id="paymentType" value="${typeResult }">  
<input type="hidden" id="pay_result" value="${payResult }">
<c:if test="${not empty auvo }">
	<input type="hidden" id="auctionMoney" value="${auvo.auctionMoney }">
</c:if>
  <script> 

  imgShow(); 
  confirmPayResult();
      
  function requestPay() {
  	var IMP = window.IMP; 
  	var date = new Date().getTime();
  	var artno = $('#artNo').val();
    var goodsname = $('#artName').val(); // 주문명
    var payment_type = $('#paymentType').val();//결제 종류(경매인지 즉시인지)
    console.log(goodsname);
    var amount = 0;
    if(payment_type=='D'){ //즉시구매
	    amount = $('#artPrice').val();
    }else if(payment_type=='A'){ //경매 낙찰
    	amount = $('#auctionMoney').val(); /* 값아직 안받아옴!!!@@ */
    }
    console.log(amount);
    var show_img = $('#show_img').val(); //이미지 파일명
    var buyer_name = $('#memberName').val(); // 주문자명
    var buyer_tel = $('#memberPhone').val(); // 주문자 연락처 - 필수
    var buyer_email = $('#memberEmail').val(); // 주문자 이메일
    var memberId = $('#memberId').val();
  	var merchant_uid = $('#artName').val() + date + $('#memberId').val();
    IMP.init('imp84678220'); // 가맹점 식별 코드
      // IMP.request_pay(param, callback) 결제창 호출
      IMP.request_pay({ // param
          pg: 'html_inicis', // pg사 코드값
          pay_method: 'card', // 결제 수단
          merchant_uid: merchant_uid, // 주문번호
          artno: artno,
          goodsname: goodsname, // 주문명
          amount: amount, // 결제 금액
          buyer_name: buyer_name, // 주문자명
          buyer_tel: buyer_tel, // 주문자 연락처 - 필수
          buyer_email: buyer_email // 주문자 이메일
      }, function (rsp) { // callback
          if (rsp.success) {// 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우
              // jQuery로 HTTP 요청
              var obj = {
                  'memberId' : memberId,
                  'artNo' : artno,
                  'artName' : goodsname,
                  'artPrice' : amount,
                  'merchantUid' : merchant_uid,
                  'paymentType' : payment_type,
                  'artFileName' : show_img
              }
      			  console.log(date);
      			  console.log(merchant_uid);

              jQuery.ajax({

                  url: 'result', // 예: https://www.myservice.com/payments/complete
                  method: 'POST',
                  headers: { 'Content-Type': 'application/json' },
                  data: JSON.stringify(obj)                      
                      // 기타 필요한 데이터 더 있으면 추가                 
              }).done(function (data) {
                // 가맹점 서버 결제 API 성공시 로직
                  var msg = '결제가 완료되었습니다.';
                  msg += '고유ID : ' + rsp.imp_uid;
                  msg += '주문 번호 : ' + rsp.merchant_uid;
                  msg += '결제 금액 : ' + rsp.paid_amount;
                  msg += '카드 승인번호 : ' + rsp.apply_num;
                  alert(msg);
                  location.href = 'result?artNo='+artno;
   
              })
          } else { // 결제 실패시
              alert("결제에 실패하였습니다. 에러 내용: " +  rsp.error_msg);
          	  
          }
      });
    }
      /* 원본이미지 출력 */
		function imgShow() {
			var show_img=$('#show_img').val();
			show_img=show_img.replace('/s_','/');
			$('#image').html('<img src="/nft-auction/arts/pay/display?fileName='+show_img+'">');
		} //end imgShow()
	
		/* 비회원 접근 */
		function confirmPayResult() {
			var result=$('#pay_result').val();
			if(result=='fail'){
				alert('비회원은 구매할 수 없습니다.');
				window.close();
			}
		} //end confirmPayResult()
 
  </script>
</body>
</html>