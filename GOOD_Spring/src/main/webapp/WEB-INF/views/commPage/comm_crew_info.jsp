<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html>
<head>
<%@ include file="../inc/head.jsp"%>
<link
	href="../plugins/drag-drop-image-uploader/dist/image-uploader.min.css"
	rel="stylesheet">

<style type="text/css">
.title-img>img {
	width: 200px;
	height: 100px;
}

/* #crew_middle { */
/* 	padding-left: 40px; */
/* } */

.col-md-8 {
	margin-left: 40px;
}

.main_header>h1 {
	position: relative;
	text-align: center;
	transition: all 0.3s ease;
	transform: translateY(0);
}

.main_header>h1:hover {
	transform: translate(0, -10px);
}

.main_header>h1>span>img {
	width: 3rem;
	height: 3rem;
	position: relative;
	left: 5px;
	bottom: 0px;
}

.form-group img{
	max-hieght: 100%;
	min-width: 100%;
	min-height: 200px;
}
</style>
</head>
<body>
	<div class="wrapper">

		<!-- 상단영역 -->
		<%@ include file="/WEB-INF/views/inc/Header.jsp"%>
		<!-- 본문영역 -->
		<div class="container">
			<!-- 대제목 -->
			<div class="row main_header">
				<h1 class="page-header page-title" id="cas_header"
					onclick="location.href='${pageContext.request.contextPath}/commPage/comm_index.do'"
					style="cursor: pointer; color: #343a40;">
					<span class="test01">커뮤니티<img
						src="${pageContext.request.contextPath}/assets/icon_img/comm_icon.png;" />
					</span>
				</h1>
			</div>
			<h1 class="page-header">${output.crew_name} 크루를 소개합니다</h1>
			<!-- 본문 상단 영역 -->
			<div class="crew_info_header "></div>
			<!-- //본문 상단 영역 -->
			<!-- 본문 중단 영역 -->
			<div class="crew_info_middle clearfix">
				<div class="col-md-3 col-sm-4" id="crew_middle">
					<div class="form-group" style="margin-bottom: 40px;">
						<span class="title-img"><img
							src="${output.crew_photo.fileUrl}"> <span class='sr-only'>이미지</span>
						</span>
						<h3>가입된 회원 수 : ${output.crew_member}명</h3>
						<h3 class="title-name">간단 소개말</h3>
						<h4 >${output.crew_sinto}</h4>
					</div>
				</div>
				<!-- 크루 상세 정보  -->
				<div class="col-md-9 col-sm-8" style="margin-top:-2%">
					<h2 class=text-center>- 크루 공지사항(설명) -</h2>
					<div class="" style="border: 4px dotted #eeee; min-height:320px;"><p style="font-size:30px; margin:1% 0 0 1%">${output.crew_dinto}</p></div>
				</div>
				<!-- 크루 상세 정보 끝 -->

			</div>
			<!--// 본문 중단 영역 -->
			<!-- 본문 하단 영역 -->



			<div class="crew_info_footer">
				<div style="padding-top: 20px;">
					<hr />
					<div class="text-center">
						<form class="form-horizontal" role="form" class="form-crew" id='crew_form'
							method="post"
							action="${pageContext.request.contextPath}/commPage/comm_crew_info_ok">
							<input type="hidden" id="crew_no" name="crew_no" value="${output.crew_no}">
							<input type="hidden" id="crew_name" name="crew_name" value="${output.crew_name}">
							<button type='submit' id="join" class="btn btn-primary">가입하기</button>
							<button type="reset" class="btn btn-info"
								onClick="location.href='${pageContext.request.contextPath}/commPage/comm_crew.do'">목록</button>
						</form>
					</div>
				</div>

			</div>
			<!--// 본문 하단 영역 -->
		</div>
	</div>
	<%@ include file="/WEB-INF/views/inc/Footer.jsp"%>


	<%@ include file="../inc/plugin.jsp"%>

	<script>
	let crew_no = $('#crew_no').val();
	let crew_name = $('#crew_name').val();
	$().ready(function(){
		
		$("#join").click(function() {
			event.preventDefault();
			 // prevent form submit
			// 확인, 취소버튼에 따른 후속 처리 구현
			swal({
				title : '확인', // 제목
				text : "해당 크루에 가입 하시겠습니까?", // 내용
				type : 'question', // 종류
				confirmButtonText : '네', // 확인버튼 표시 문구
				showCancelButton : true, // 취소버튼 표시 여부
				cancelButtonText : '아니오' // 취소버튼 표시 문구
				
			}).then(function(result) { // 버튼이 눌러졌을 경우의 콜백 연결
				if (result.value) { // 확인 버튼이 눌러진 경우
					$.ajax({
						url: getContextPath()+'/commPage/comm_crew_info_ok',
						method:'post',
						data: {crew_no, crew_name},
						success:function(json){
							swal('성공', crew_name+' 크루에 가입되었습니다.', 'success' 
								).then(function(result){
							window.location = getContextPath() + "/commPage/comm_crew_bbs.do?crew_no=" 
													+ crew_no + "&crew_name=" + crew_name;
							});
						},error:function(data, status, error){
							var error_msg =data.responseJSON.rt
							swal({
								title : "에러",
								text :error_msg,
								type : "error"
								})
						return false; // <-- 실행 중단
						}
					});
				} else if (result.dismiss === 'cancel') { // 취소버튼이 눌러진 경우
					swal('취소', '가입이 취소되었습니다.', 'error');
				}

			});
			
		});
	});
	</script>


</body>
</html>