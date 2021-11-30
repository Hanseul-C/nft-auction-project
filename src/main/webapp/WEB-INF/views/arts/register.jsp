<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<title>작품 등록 페이지</title>
<style type="text/css">
.file-drop {
	width: 100;
	height: 100px;
	border: 1px solid grey;
}
</style>
</head>
<body style="text-align: center;">
	<h1>작품 등록 페이지</h1>
	<form method="post">
		<input type="hidden" id="member_id" name="memberId" value="${sessionScope.memberId }">
		<input type="text" id="art_name" name="artName" value="" placeholder="작품명 입력" required><br>
		<input type="number" name="artPrice" placeholder="즉시판매가 입력" required><br>
		<input type="text" id="art_content" value="" name="artContent" placeholder="작품설명 입력" required><br>
		작품 게시기간 설정<br> <input type="datetime-local" name="artShowDate"
			required><br> <input type="number" name="artBasicFee"
			placeholder="경매시작금 입력" required><br> 이미지 등록<br>
		<div class="file-drop" style="color: grey;">이미지를 drop해주세요.</div>
		<div class="upload-list"></div>
		<input type="hidden" id="file_name" name="artFileName" value=""
			required> 
		<input type="hidden" id="memberAccount" name="memberAccount" value="" required>	
		<input type="hidden" id="uri" name="artJsonUri" value="" required>
		<input type="submit" value="등록하기">
	</form>
	<!-- JavaScript -->
	<script type="text/javascript">
		if (typeof window.klaytn !== 'undefined') {
			console.log('kaikas installed!') // 카이카스가 설치된 경우
			const accounts = klaytn.enable();
			const account = accounts[0];
		}
		console.log('현재 네트워크 : ' + klaytn.networkVersion);
		console.log('현재 지갑의 주소 : ' + klaytn.selectedAddress);
	
		$(function(){
			$('.file-drop').on('dragenter dragover', function(event){
				//drop 이벤트의 기본 동작을 막음
				event.preventDefault();
			}); //end dragenter dragover
			
			$('.file-drop').on('drop', function(event){
				event.preventDefault();
				
				/*ajax를 이용해 서버로 파일업로드*/
				var formData=new FormData();
				var files=event.originalEvent.dataTransfer.files; //드래그한 file 정보
				var i=0;
				
				for(i=0;i<files.length; i++){
					console.log(files[i]);
					//서버로 보낼 form-data 작성
					formData.append("files", files[i]);					
				}
				
				$.ajax({
					type:'post',
					url:'upload-ajax',
					data:formData,
					processData:false,
					contentType:false,
					success: function(fileName){
					    if (typeof window.klaytn !== 'undefined') {
                  			/* console.log('kaikas installed!') // 카이카스가 설치된 경우
 
                 			console.log('현재 네트워크 : ' + klaytn.networkVersion);
                  			console.log('현재 지갑의 주소 : ' + klaytn.selectedAddress);
          
                  			const provider = window['klaytn']; // provider에 주입하기.
                  			window.klaytn.enable(); // 열기! */
                  			
                  			// metadata api로 json파일 서버에 올리기
                  			var artName = $('#art_name').val();
                  			var description = $('#art_content').val();
                  			var image = "http:/localhost:8080/nft-auction/arts/display?fileName=" + fileName;
                  			var minter = $('#member_id').val();
                  			
                  			const settings = {
                  			        "async": true,
                  			        "crossDomain": true,
                  			        "url": "https://metadata-api.klaytnapi.com/v1/metadata",
                  			        "method": "POST",
                  			        "headers": {
                  			          "Content-Type": "application/json",
                  			          "x-chain-id": "1001",
                  			          "Authorization": "Basic S0FTS0VNTkMxRDg4UTdHSDFUTlZMWkhSOkhPa3lvbEpnbnFlaGhrNDRGOWVjSWNiSENONm0tSEJrLUFSV01PWXQ="
                  			        },
                  			        "processData": false,
                  			        "data": "{\n  \"metadata\": {\n    \"name\": \"" + artName + "\"," 
                  			            + "\n    \"description\": \"" + description + "\"," 
                  			            + "\n    \"image\": \"" + image + "\"," 
                  			            + "\n   \"minter\": \"" + minter + "\""  
                  			            + "}\n}"
                  			};

                  			$.ajax(settings).done(function (response) {
                  			  	console.log("metadata api 응답 : "  + JSON.stringify(response));
                  			   	console.log("metadata의 uri : " + typeof(response['uri']));
                  			   	// 이거 DB에 넣어버리고 서버단으로 전송하기!
                  			   	$('#uri').attr('value', response['uri']);    
                  			});
                  			
             			 } else { // 설치되지 않은 경우, 설치할 수 있도록 유도하기.
                 			location.href = 'https://chrome.google.com/webstore/detail/kaikas/jblndlipeogpafnldhgmapagcccfchpi?hl=ko';
             			 }
					    
						console.log(fileName); //서버에 업로드된 파일이름을 가지고옴
						
						if(fileName=='fail'){
							alert('jpg, png, gif 파일만 등록할 수 있습니다.');
						}else{
							$('.upload-list').html("<img src='/nft-auction/arts/display?fileName="+fileName+"'>");
							$('#file_name').attr('value', fileName);							
						}
					}//success
				}); //end ajax
			}); //end drop
			
			// 제출을 할때 정보들이 db에도 들어가고, json형식으로 서버에 올라감.
			
		}); //end documnet
	</script>
</body>
</html>