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
<title>환급 팝업창</title>
<!-- JavaScript -->
<script type="text/javascript">
	function confirm(){
		var money=$('#refund_money').val();
		var profit=$('#profit').val();
		
		if(money>profit){ //잔액보다 많은 액수를 입력한 경우
			$('#confirm_money').css('color', 'red');
			$('#confirm_money').html('잔액보다 큰 액수는 입력할 수 없습니다.');
			return false;
		}
		if(money<0){
			$('#confirm_money').css('color', 'red');
			$('#confirm_money').html('정상적인 액수를 입력해주세요');
			return false;
		}
		return true;
	} //end confirm();
</script>
</head>
<body style="text-align: center">
	<div class="container m-5 p-5">
		<div class="card m-5 p-5">
			<div class="card-body p-5">
				<p>잔액 : ${profit }</p>
				<button>계좌 연동</button>
				<hr>
				계좌 입력 
				<form action="refund" method="post" onsubmit="return confirm();">
					<input type="hidden" name="memberId" value="${sessionScope.memberId }">
					<input type="text" class="form-control" name="refundAccount" placeholder="계좌 입력" required><br>
					<input type="number" class="form-control" id="refund_money" name="refundMoney" placeholder="정산액 입력" required><br>
					<span id="confirm_money"></span>
					<input type="submit" value="환급하기">
				</form>
			</div>
		</div>
	</div>
	<!-- hidden -->
	<input type="hidden" id="profit" value="${profit }">
	<input type="hidden" id="refundResult" value="${refundResult }">
	<script type="text/javascript">
		confirmResult();
		
		function confirmResult() {
			var refundResult=$('#refundResult').val();
			
			if(refundResult=='success'){
				window.close();
			}
		}
	</script>
</body>
</html>