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
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<!-- JavaScript : submitAble() -->
<script type="text/javascript">		
	var id_check=false; //아이디 중복체크
	var member_check=false; //본인인증 확인
	var pw_check=false; //비밀번호 확인
 		
	/* 가입하기 버튼 활성화 */
	function submitAble() {
		var phone=$('#member_phone').val();
		var email=$('#member_email').val();
		//전화번호 정규표현식 적용
		var phone_check=
			/^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
		//phone=phone.replace(/(.{3,4})/g,'-');
		//이메일 정규표현식 적용
		var email_check=
			/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;

		console.log(id_check+", "+member_check+", "+pw_check);
		if(id_check==false){
			alert("아이디 중복체크를 해주세요.");
			return false;
		}
		if(member_check==false){
			alert("본인인증을 해주세요.");
			return false;
		}
		if(pw_check==false){
			alert("비밀번호 확인을 진행해주세요.");
			return false;
		}
		if(phone_check.test(phone) === false){
			alert('올바른 전화번호를 입력해주세요.');
			return false;
		}
		if (email_check.test(email) === false) {
	    	alert('올바른 이메일 형식을 입력해주세요.');
	    	return false;
	    }
		return true;
	}//end submitAble()
</script>
<title>회원가입 페이지</title>
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
					<c:if test="${empty sessionScope.memberId }">
						<li class="nav-item"><a class="nav-link" href="login">로그인</a>
						</li>
						<li class="nav-item"><a class="nav-link"
							href="sign-up">회원가입</a></li>
					</c:if>
					<c:if test="${not empty sessionScope.memberId }">
						<li class="nav-item"><a class="nav-link" href="logout">로그아웃</a></li>
						<li class="nav-item"><a class="nav-link"
							href="my-page/member">마이페이지</a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</nav>
	<br>
	<!-- body -->
	<div class="container" style="padding-bottom: 200px">
		<div class="row justify-content-center">
			<div class="col-sm-6">
				<div class="card border-primary mt-5">
					<div class="card-body p-5">
						<h2>회원가입</h2>
						<form action="sign-up" method="post" onsubmit="return submitAble();">
							<div class="input-group mb-3">
								<input type="text" class="form-control" id="member_id" name="memberId" placeholder="아이디 입력" required aria-label="아이디 입력" aria-describedby="check_id">
								<button class="btn btn-outline-secondary" type="button" id="check_id">아이디 중복체크</button>
							</div>
							<div id="check_id_result" class="mb-3"></div>
							<div class="input-group mb-3">
							  <input type="text" class="form-control" id="member_name" name="memberName" placeholder="실명 입력" required aria-label="실명 입력" aria-describedby="check_confirm">
							  <button class="btn btn-outline-secondary" type="button" id="check_confirm">본인인증</button>
							</div>
							<input type="hidden" id="member_uid" name="memberUid" value="">
							<p><input type="password" class="form-control" id="member_pw" name="memberPassword" placeholder="비밀번호 입력" required></p>
							<p><input type="password" class="form-control" id="confirm_pw" placeholder="비밀번호 확인" required></p>
							<div id="confirm_pw_result" class="mb-3"></div>
							<p><input type="text" class="form-control" name="memberNickname" placeholder="닉네임 입력" required></p>
							<p><input type="text" class="form-control" id="member_phone" name="memberPhone" placeholder="전화번호 입력" required></p>
							<p><input type="text" class="form-control" id="member_email" name="memberEmail" placeholder="이메일 입력" required></p>
							<p><button class="enableEthereumButton btn btn-primary" id="btn-kaikas">klaytn 연동</button>
							<input type="submit" class="btn btn-primary" value="가입하기"></p>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- footer -->
<<<<<<< HEAD
<<<<<<< HEAD
	<footer class="bd-footer py-5 mt-5 bg-warning sticky-bottom">
=======
	<footer class="bd-footer py-5 mt-5 bg-warning fixed-bottom">
>>>>>>> refs/remotes/origin/develop-yed
		<div class="container py-5">
=======
	<div class="mt-5 p-3 bg-light">
		<div style="bottom: 0; height: 200px;">
>>>>>>> origin/develop-yed
			<h4>NFT-AUCTION</h4>
			<hr>
			<br>
			<a href="#">이용약관</a> &nbsp;
			<a href="#">사이트안내</a>
			<br><br>
			<small>문의 nftauction_admin@gmail.com</small>
		</div>
	</div>
	<!-- JavaScript -->
	<script type="text/javascript">
		$(function() {
			var IMP = window.IMP;
			IMP.init('iamport'); //관리자 체험용
			
			/* 아이디 중복 체크 */
			$('#check_id').click(function(){
				var member_id=$('#member_id').val();
				if(!member_id){
            		$('#check_id_result').css('color', 'red');
					$('#check_id_result').html("아이디를 입력해주세요.");
				}else{
					$.ajax({
						type:'get',
		                url:'rest/id-check/'+member_id,
		                success:function(result, status){
		                	console.log(result + " : "+ status);
		                	if(result==0){
		                		id_check=true;
		                		$('#check_id_result').css('color', 'green');
			                	$('#check_id_result').html("사용가능한 아이디입니다.");
		                	}else{ // 1인 경우
		                		id_check=false;
		                		$('#check_id_result').css('color', 'red');
			                	$('#check_id_result').html("중복된 아이디입니다.");
		                	}
		                }
					}); //end ajax
				}
			}); //end check_id click
			
			$('#member_id').change(function(){
				if(id_check==true){ //중복체크하고 다시 id를 변경한 경우
					id_check=false;
				}
			}); //end member_id change()
	
			/* 회원 본인인증 */
			$("#check_confirm").click(function() {
				var member_name = $('#member_name').val();
				var member_id=$('#member_id').val();
				
				if(!member_name){
					alert("이름을 입력해주세요.");
					if(id_check!=true){
						alert("아이디 중복체크를 해주세요.");
					}
				}else{
					IMP.certification({
						name : member_name,
						merchant_uid : 'member_' + member_id // 고유 인증id
					}, function(rsp) {
						if (rsp.success) {
							// 인증성공
							console.log(rsp.imp_uid);
							console.log(rsp.merchant_uid);

							$.ajax({
								type : 'POST',
								url : 'rest/confirm',
								data : {memberUid : rsp.merchant_uid},
								success:function(result, status){
									$('#member_uid').attr('value', result);
									$('#member_name').attr('readonly',true);
									$('#check_confirm').attr('disalbed', true);
									member_check = true;
									alert("본인인증에 성공했습니다.");
								}
							});
						} else {
							// 인증취소 또는 인증실패
							member_check = false;
							/* var msg = '인증에 실패하였습니다.<br>';
							msg += '에러내용 : ' + rsp.error_msg; */
							//본인인증 오류로 인해 임시처리
							var msg='진행하세여';
							$('#member_uid').val('member_'+member_id); 
							member_check = true;
							alert(msg);
						}
					}); //end IMP.certification
				}
			}); //end check_confirm click()
			
			/* 비밀번호 확인 */
			$('#member_pw').blur(function(){
				var member_pw=$('#member_pw').val();
				var confirm_pw=$('#confirm_pw').val();
				
				if(confirm_pw){ //비밀번호 확인 값이 입력되었을때만 
					if(member_pw==confirm_pw){
						pw_check=true;
						$('#confirm_pw_result').css('color','green');
						$('#confirm_pw_result').html("비밀번호가 일치합니다.");
					}else{
						pw_check=false;
						$('#confirm_pw_result').css('color','red');
						$('#confirm_pw_result').html("비밀번호가 일치하지 않습니다.");
					}
				}
				
			}); //end member_pw blur()
			
			$('#confirm_pw').blur(function(){
				var member_pw=$('#member_pw').val();
				var confirm_pw=$('#confirm_pw').val();
				
				if(!member_pw || !confirm_pw){
					pw_check=false;
					$('#confirm_pw_result').css('color','red');
					$('#confirm_pw_result').html("비밀번호를 입력하세요.");
				}else{
					if(member_pw==confirm_pw){
						pw_check=true;
						$('#confirm_pw_result').css('color','green');
						$('#confirm_pw_result').html("비밀번호가 일치합니다.");
					}else{
						pw_check=false;
						$('#confirm_pw_result').css('color','red');
						$('#confirm_pw_result').html("비밀번호가 일치하지 않습니다.");
					}
				}

			}); //end confirm_pw blur()
			
			/* klaytn 적용 */
			$('#btn-kaikas').click(function() {
	               if (typeof window.klaytn !== 'undefined') {
	                   console.log('kaikas installed!') // 카이카스가 설치된 경우
	                   console.log('현재 네트워크 : ' + klaytn.networkVersion);
	                   console.log('현재 지갑의 주소 : ' + klaytn.selectedAddress);
	                   
	                   klaytn.enable(); // 열기!
	                   // Kaikas user detected. You can now use the provider.
	                   const provider = window['klaytn'] // provider에 주입하기.
	               } else { // 설치되지 않은 경우, 설치할 수 있도록 유도하기.
	                   location.href = 'https://chrome.google.com/webstore/detail/kaikas/jblndlipeogpafnldhgmapagcccfchpi?hl=ko';
	                          
	               }
            }); // end btn-kaikas.click()

			/* 전화번호 형식적용 */
			$('#member_phone').keyup(function(){
				var member_phone=$('#member_phone').val();
				console.log(member_phone);
				//'-' 입력 막기
				member_phone=member_phone.replace(/[^0-9]/g,'');
				//전화번호 '-' 자동 삽입
				var regPhone=member_phone.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3")
				$('#member_phone').val(regPhone);
			}); //end member_phone keyup()

			
		}); //end document
	</script>
</body>
</html>