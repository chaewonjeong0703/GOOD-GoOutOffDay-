<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<header>
	<div class="navbar navbar-default clearfix" role="navigation"
		id="header"
		style="min-height: 50px;">
		<div class="container clearfix" style="padding: 0;">
			<div class="row clearfix"
				style="padding-bottom: 0 !important; margin-right: 0;">
				<div class="col-md-3" id="h_logo">
					<a href="<%=request.getContextPath()%>/"
						style="position: relative; z-index: 999999;"> <img
						id="logo_img"
						src="${pageContext.request.contextPath }/assets/icon_img/logo.png"
						style="width: 250px; height: 53px;" />
					</a>
				</div>
				<div class="col-md-9" style="padding-right: 0;">
					<%--로그인 회원가입 프로필--%>
					<c:choose>
						<c:when test="${login_info == null }">
							<div class="clearfix" id="login_join_box">
								<div class="pull-right" id="login_join">
									<button class="btn btn-link"
										style="color: #0098ed; font-size: 1em; margin-top: 5px; padding-top: 0; padding-bottom: 0; text-decoration: none; border: 0; outline: 0;"
										onclick="location.href='${pageContext.request.contextPath}/mainPage/login.do'">
										<i class="glyphicon glyphicon-thumbs-up"></i> <strong>
											로그인</strong>
									</button>
									<!-- 										<button class="btn btn-link" -->
									<!-- 											style="color: #0069a6; text-decoration: none; border: 0; outline: 0;" -->
									<%-- 											onclick="location.href='${pageContext.request.contextPath}/mainPage/join.do'"> --%>
									<!-- 											<i class="glyphicon glyphicon-link"></i> <strong> -->
									<!-- 												회원가입</strong> -->
									<!-- 										</button> -->
								</div>
							</div>
						</c:when>
						<c:when
							test="${login_info.getUser_id() != null && login_info.isUser_admin()==false}">
							<div class="clearfix" id="login_join_box">
								<div class="pull-right" id="login_join">
									<div class="pull-right" style="padding: 0 10px;">
										<div>
											<a id="account" href="#" role="button"><img
												style="border-radius: 20px"
												onerror="this.src='<%=request.getContextPath()%>/assets/img/profile_default.png'"
												src="${login_info.getUser_photo().getFileUrl()}"
												width="40px" height="40px"></img><span class="hidden">myPage</span></a>
										</div>
									</div>
									<%-- 계정 정보 모달 --%>
									<div class="account_modal" aria-label="계정 정보"
										aria-hidden="true"
										style="overflow: hidden; display: none; position: absolute; top: 0px; right: -127px; width: 300px; z-index: 1000001; margin-top: 67px; background-color: #fff; border: 1px solid #ccc; border-radius: 10px; box-shadow: 0.1px 0.1px 2px rgba(0, 0, 0, 0.5);">
										<div class="text-center" style="padding: 30px 0;">
											<img style="border-radius: 60px"
												onerror="this.src='<%=request.getContextPath()%>/assets/img/profile_default.png'"
												src="${login_info.getUser_photo().getFileUrl()}"
												width="120px" height="120px"></img><span class="hidden">myPage</span>
										</div>
										<div class="account-info text-center">이름:
											${login_info.getUser_name()}</div>
										<div class="account-info text-center">닉네임:
											${login_info.getUser_nick()}</div>
										<div class="account-info text-center"
											style="padding-bottom: 30px;">ID:
											${login_info.getUser_id()}</div>
										<div class="account-info btn-group"
											style="padding: 0; width: 100%;">
											<a
												href="${pageContext.request.contextPath}/myPage/myPage_bookmark.do"
												type="button" id="bookmarkPage" class="btn btn-link"
												style="border-radius: 0; border: 0; width: 33.3%;"> <i
												class="fa fa-heart" aria-hidden="true" role="button"
												style="color: black;"></i> 찜 목록
											</a> <a
												href="${pageContext.request.contextPath}/myPage/myPage_index.do"
												type="button" id="myPage" class="btn btn-link"
												style="border-radius: 0; width: 33.3%; border: 0;"><i
												class="glyphicon glyphicon-cog"></i>My Page</a>
											<button type="button" class="btn btn-link logout-btn"
												style="border-radius: 0; border: 0; width: 33.3%;">
												<i class="glyphicon glyphicon-log-out"></i>로그아웃
											</button>
										</div>
									</div>
									<%-- 계정정보모달 활성화시 뒷배경 --%>
									<div class="gray_layer"></div>
								</div>
							</div>
						</c:when>
						<%--//로그인 회원가입 프로필--%>
						<c:when
							test="${login_info.getUser_id() != null && login_info.isUser_admin()==true}">
							<div class="clearfix" id="login_join_box">
								<div class="pull-right" id="login_join">
									<button class="btn btn-link"
										style="color: #0098ed; font-size: 1em; margin-top: 5px; padding-top: 0; padding-bottom: 0; text-decoration: none; border: 0; outline: 0;"
										onclick="location.href='${pageContext.request.contextPath}/adminPage/admin_index.do'">
										<i class="glyphicon glyphicon-cog"></i> <strong> 관리자</strong>
									</button>
									<!-- 										<button class="btn btn-link logout-btn" -->
									<!-- 											style="color: #0069a6; text-decoration: none; border: 0; outline: 0;"> -->
									<!-- 											<i class="glyphicon glyphicon-link"></i> <strong> -->
									<!-- 												로그아웃</strong> -->
									<!-- 										</button> -->
								</div>
							</div>
						</c:when>
					</c:choose>

					<!--네비게이션, 검색바-->
					<div class="row clearfix"
						style="padding-bottom: 0 !important; margin-right: 0;" id="navbar">
						<!-- 반응형 햄버거 -->
						<div class="navbar-header ">
							<button type="button" class="navbar-toggle pull-left"
								id="navbar-toggle" style="margin-left: 25px;"
								data-toggle="collapse" data-target="#navi_search">
								<span class="sr-only">메뉴열기</span> <span class="icon-bar"></span>
								<span class="icon-bar"></span> <span class="icon-bar"></span>
							</button>
						</div>
						<!-- //반응형 햄버거 -->
						<!-- 네비게이션(서브메뉴) -->
						<div class="collapse navbar-collapse clearfix " id="navi_search"
							style="padding-left: 29px;">
							<!-- 반응형 햄버거 아코디언 -->
							<div class="panel-group" id="accodian"
								style="border-bottom: 0; margin-bottom: 0 !important; margin-top: 10px; font-size: 20px">
								<div class="panel panel-default">
									<div class="panel-heading" style="background: #fff;">
										<div class="panel-title">
											<button class="accordian-toggle btn btn-link btn-block"
												style="border: 0; outline: 0; text-decoration: none; font-size: 20px; text-align: center;"
												onclick="location.href='${pageContext.request.contextPath}/bicyclePage/bicycle_index.do'">
												<img
													src="<%=request.getContextPath()%>/assets/icon_img/bicycle1_icon.png"
													style="width: 30px; height: 24px; padding: 0 3px;" />자전거
											</button>
										</div>
									</div>
								</div>
								<div class="panel panel-default">
									<div class="panel-heading" style="background: #fff;">
										<div class="panel-title">
											<button class="accordian-toggle btn btn-link btn-block"
												data-toggle="collapse" data-parent="#accordion"
												data-target="#collapseOne"
												style="border: 0; outline: 0; text-decoration: none; font-size: 20px; text-align: center;">
												<img
													src="<%=request.getContextPath()%>/assets/icon_img/walk_icon.png"
													style="width: 30px; height: 24px; padding: 0 3px;" />걷기
											</button>
										</div>
									</div>
									<div id="collapseOne" class="panel-collapse collapse">
										<div class="panel-body">
											<a class="btn-block"
												href="${pageContext.request.contextPath}/walkPage/walk_index.do">걷기
												메인</a>
										</div>
										<div class="panel-body">
											<a class="btn-block"
												href="${pageContext.request.contextPath}/walkPage/walk_search.do">코스목록</a>
										</div>
										<div class="panel-body">
											<a class="btn-block"
												href="${pageContext.request.contextPath}/walkPage/walk_log.do">걷기로그</a>
										</div>
									</div>
								</div>
								<div class="panel panel-default">
									<div class="panel-heading" style="background: #fff;">
										<div class="panel-title">
											<button class="accordian-toggle btn btn-link btn-block"
												data-toggle="collapse" data-parent="#accordion"
												data-target="#collapseTwo"
												style="border: 0; outline: 0; text-decoration: none; font-size: 20px; text-align: center;">
												<img
													src="<%=request.getContextPath()%>/assets/icon_img/cas_icon.png"
													style="width: 30px; height: 24px; padding: 0 3px;" />문화체육
											</button>
										</div>
									</div>
									<div id="collapseTwo" class="panel-collapse collapse">
										<div class="panel-body">
											<a class="btn-block"
												href="${pageContext.request.contextPath}/casPage/cas_index.do">문화체육
												메인</a>
										</div>
										<div class="panel-body">
											<a class="btn-block"
												href="${pageContext.request.contextPath}/casPage/cas_themeList.do?cas=문화">문화
												창의 체험</a>
										</div>
										<div class="panel-body">
											<a class="btn-block"
												href="${pageContext.request.contextPath}/casPage/cas_themeList.do?cas=교육">교육
												자기 계발</a>
										</div>
										<div class="panel-body">
											<a class="btn-block"
												href="${pageContext.request.contextPath}/casPage/cas_themeList.do?cas=대관">장소대여</a>
										</div>
										<div class="panel-body">
											<a class="btn-block"
												href="${pageContext.request.contextPath}/casPage/cas_themeList.do?cas=체육">체육시설</a>
										</div>
									</div>
								</div>
								<div class="panel panel-default">
									<div class="panel-heading" style="background: #fff;">
										<div class="panel-title">
											<button class="accordian-toggle btn btn-link btn-block"
												data-toggle="collapse" data-parent="#accordion"
												data-target="#collapseThree"
												style="border: 0; outline: 0; text-decoration: none; font-size: 20px; text-align: center;">
												<img
													src="<%=request.getContextPath()%>/assets/icon_img/comm_icon.png"
													style="width: 30px; height: 24px; padding: 0 3px;" />커뮤니티
											</button>
										</div>
									</div>
									<div id="collapseThree" class="panel-collapse collapse">
										<div class="panel-body">
											<a class="btn-block"
												href="${pageContext.request.contextPath}/commPage/comm_index.do">커뮤니티
												메인</a>
										</div>
										<div class="panel-body">
											<a class="btn-block"
												href="${pageContext.request.contextPath}/commPage/comm_crew.do">크루</a>
										</div>
										<div class="panel-body">
											<a class="btn-block"
												href="${pageContext.request.contextPath}/commPage/comm_myCourse.do?pageNo=1">나만의
												코스</a>
										</div>
										<div class="panel-body">
											<a class="btn-block"
												href="${pageContext.request.contextPath}/commPage/comm_myPost.do">내가
												쓴 글</a>
										</div>
									</div>
								</div>
							</div>
							<!-- //반응형 햄버거 아코디언 -->
							<ul class="nav navbar-nav navbar-left" id="cbp-tm-menu">
								<!--자전거메뉴-->
								<li><a
									href="${pageContext.request.contextPath}/bicyclePage/bicycle_index.do"><img
										src="<%=request.getContextPath()%>/assets/icon_img/bicycle1_icon.png"
										style="width: 30px; height: 24px; padding: 0 3px;" />자전거</a></li>
								<!--걷기메뉴-->
								<li
									onclick="location.href='${pageContext.request.contextPath}/walkPage/walk_index.do'"
									style="cursor: pointer;"><a><img
										src="<%=request.getContextPath()%>/assets/icon_img/walk_icon.png"
										style="width: 30px; height: 24px; padding: 0 3px;" />걷기</a>
									<ul class="cbp-tm-submenu" style="z-index: 1000;">
										<li><a
											href="${pageContext.request.contextPath}/walkPage/walk_search.do"
											class="cbp-tm-icon-archive">코스목록</a></li>
										<li><a
											href="${pageContext.request.contextPath}/walkPage/walk_log.do"
											class="cbp-tm-icon-clock">걷기로그</a></li>
									</ul></li>
								<!--문화체육 메뉴-->
								<li
									onclick="location.href='${pageContext.request.contextPath}/casPage/cas_index.do'"
									style="cursor: pointer;"><a><img
										src="<%=request.getContextPath()%>/assets/icon_img/cas_icon.png"
										style="width: 30px; height: 24px; padding: 0 3px;" />문화 체육</a>
									<ul class="cbp-tm-submenu" style="z-index: 1000;">
										<li><a
											href="${pageContext.request.contextPath}/casPage/cas_themeList.do?cas=문화"
											class="cbp-tm-icon-pencil">문화 창의 체험</a></li>
										<li><a
											href="${pageContext.request.contextPath}/casPage/cas_themeList.do?cas=교육"
											class="cbp-tm-icon-contract">교육 자기 계발</a></li>
										<li><a
											href="${pageContext.request.contextPath}/casPage/cas_themeList.do?cas=대관"
											class="cbp-tm-icon-pictures">장소대여</a></li>
										<li><a
											href="${pageContext.request.contextPath}/casPage/cas_themeList.do?cas=체육"
											class="cbp-tm-icon-location">체육시설</a></li>
									</ul></li>
								<!--커뮤니티 메뉴-->
								<li
									onclick="location.href='${pageContext.request.contextPath}/commPage/comm_index.do'"
									style="cursor: pointer;"><a><img
										src="<%=request.getContextPath()%>/assets/icon_img/comm_icon.png"
										style="width: 30px; height: 24px; padding: 0 3px;" />커뮤니티</a>
									<ul class="cbp-tm-submenu" style="z-index: 1000;">
										<li><a
											href="${pageContext.request.contextPath}/commPage/comm_crew.do"
											class="cbp-tm-icon-users">크루</a></li>
										<li><a
											href="${pageContext.request.contextPath}/commPage/comm_myCourse.do?pageNo=1"
											class="cbp-tm-icon-location">나만의 코스</a></li>
										<li><a
											href="${pageContext.request.contextPath}/commPage/comm_myPost.do"
											class="cbp-tm-icon-pencil">내가 쓴 글</a></li>
									</ul></li>
							</ul>
							<!-- 검색바 -->
							<form method="get"
								action="${pageContext.request.contextPath }/mainPage/search.do"
								class="navbar-form navbar-right" role="search"
								style="border-bottom: 0 !important; border-left: 1px solid #ccc;">
								<div class="form-group input-group" style="margin-bottom: 0 !important;">
									<input type="search" name="keyword" class="form-control"
										placeholder="검색"> <span class="input-group-btn">
										<button class="btn btn-blue" style="padding: 3.3px 10px; background-color: #cddfff;">
											<i class="glyphicon glyphicon-search" style="color: #ffffff; font-size: 20px; top: 3.3px;"></i>
										</button>
									</span>
								</div>
							</form>
							<!-- //검색바 -->
						</div>
						<!-- //네비게이션(서브메뉴) -->
					</div>
					<!--//네비게이션, 검색바-->
				</div>
			</div>
		</div>
	</div>
</header>
<script type="text/javascript">
	//절대경로 구하기
	function getContextPath() {
		var hostIndex = location.href.indexOf(location.host)
				+ location.host.length;
		var contextPath = location.href.substring(hostIndex, location.href
				.indexOf('/', hostIndex + 1));
		return contextPath;
	}

	// 	$(function(){
	// 		$(window).resize(
	// 			function(e) {
	// 				if ($(window).width() > 992) {
	// 					$("#logo_img").attr({"src":"${pageContext.request.contextPath }/assets/icon_img/logo.png",
	// 						"style":"width: 250px; height: 53px;"});
	// 				}
	// 			}
	// 		)
	// 	});
	// 	jQuery(document).ready(function($){

	// 		$(window).on('resize', function() {
	// 		if($(window).width() > 767) {
	// 			$("#logo_img").attr({"src":"${pageContext.request.contextPath }/assets/icon_img/logo.png",
	// 				"style":"width: 250px; height: 53px;"});
	// 		} else {
	// 			$("#logo_img").attr({"src":"${pageContext.request.contextPath }/assets/icon_img/logo.png",
	// 				"style":"width: 0; height: 0;"});
	// 		}
	// 		}).resize();
	// 		});

	$(function() {
		//계정정보버튼 누르면-->모달 on,off  모바일 환경에서 회색창 생김.
		$("#account").click(function() {
			if ($('.account_modal').css("display") == "none") {
				$('.account_modal').fadeIn(300);
				if ($(window).width() < 992) {
					$('.gray_layer').fadeIn(300);
				}
			} else if ($('.account_modal').css("display") == "block") {
				$('.account_modal').fadeOut(300);
				if ($(window).width() < 992) {
					$('.gray_layer').fadeOut(300);
				}
			}
		});
		//회색배경창 누르면 모달,회색창 꺼짐.
		$(".gray_layer").click(function() {
			if ($(window).width() < 992) {
				$('.gray_layer').fadeOut(300);
			}
			$('.account_modal').fadeOut(300);
		});

		$(window).resize(
				function(e) {
					if ($(window).width() >= 992
							&& $('.account_modal').css("display") == "block") {
						$('.gray_layer').fadeOut(300);
					}
					if ($(window).width() < 992
							&& $('.account_modal').css("display") == "block") {
						$('.gray_layer').fadeIn(300);
					}
				});

		//로그아웃 ajax
		$('.logout-btn').click(function(e) {
			$.ajax({
				//결과를 읽어올 url
				url : getContextPath() + '/mainPage/logout',
				method : 'get',
				data : {},
				dataType : 'html',
				success : function(req) {
					//페이지 새로고침
					window.location.href = getContextPath()
				}

			})
		});
	});
</script>