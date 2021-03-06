<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!doctype html>
<html>
<head>

<%@ include file="/WEB-INF/views/inc/head.jsp"%>
<style>
.crew_middle .thumbnail .caption p {
	color: #848c94;
}

p {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

h4 {
	overflow: hidden;
	text-overflow: ellipsis;
	display: -webkit-box;
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
	min-height: 38px;
	margin-top: 0;
}
.header h1 {
	position: relative;
}

.header h1:after {
	content: "";
	background-image:
		url("${pageContext.request.contextPath}/assets/icon_img/crew_icon.png");
	background-size: 100% 100%;
	width: 30px;
	height: 30px;
	display: inline-block;
	margin-left: 10px;
	position: absolute;
	top: 2px;
}
/** 호버 CSS **/
.item {
	position: relative;
	transition: all 0.3s ease;
	transform: translateY(0);
	padding: 0;
}

.item:hover {
	transform: translate(0, -2px);
	box-shadow: 0 2px 4px rgba(102, 109, 117, 0.4);
}
/* 폼 전체 박스 */
.title-img>img {
	width: 100px;
	height: 100px;
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

.thumbnail img {
	max-hieght: 100%;
	min-width: 100%;
	height: 180px;
}

.pagination {
	margin-top: -100px;
}

.btn_se {
	padding-top: 0;
}

#btn1 {
	margin-left: 2px;
}

@media ( min-width :400px) {
	#dropbox {
		width: 20%;
		padding-top: 0;
	}
}

@media ( max-width :400px) {
	#dropbox {
		width: 100%;
	}
	#search {
		width: 92%;
		margin-left: 15px;
	}
}
</style>
</head>
<body>
	<div class="wrapper">

		<!-- 상단 영역 -->
		<%@ include file="../inc/Header.jsp"%>
		<!-- 본문 영역 -->
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
			<div class="header">
				<h1 style="color: #343a40;">크루</h1>
			</div>

			<!-- 크루 본문영역 상단 -->

			<form class="form-horizontal" name="crew_header" id="crew_header"
				role="form" method="get"
				action="${pageContext.request.contextPath}/commPage/comm_crew.do">
				<div class="form-group">

					<div
						class="col-lg-3 col-md-3 col-sm-3 col-xs-3 col-md-offset-1 col-xs-offset-1 "
						role="search" id="search">
						<div class="form-group input-group">
							<input type="text" class="form-control" placeholder="크루를 검색해보세요."
								style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;"
								id="keyword" name="keyword" value=""><span
								class="input-group-btn">
								<button class="btn btn-blue" type="submit"
									style="margin-left: -5px;">
									<i class="glyphicon glyphicon-search"></i>
								</button>
							</span>
						</div>
					</div>

					<div class="col-lg-2 col-xl-2 col-md-2 col-sm-2 col-xs-2 "
						id="dropbox">
						<select class="form-control" id="crew_area" name="crew_area">
							<option value="">지역</option>
							<option value="강남구">강남구</option>
							<option value="강동구">강동구</option>
							<option value="강북구">강북구</option>
							<option value="강서구">강서구</option>
							<option value="관악구">관악구</option>
							<option value="광진구">광진구</option>
							<option value="구로구">구로구</option>
							<option value="금천구">금천구</option>
							<option value="노원구">노원구</option>
							<option value="도봉구">도봉구</option>
							<option value="동대문구">동대문구</option>
							<option value="동작구">동작구</option>
							<option value="마포구">마포구</option>
							<option value="서대문구">서대문구</option>
							<option value="서초구">서초구</option>
							<option value="성동구">성동구</option>
							<option value="성북구">성북구</option>
							<option value="송파구">송파구</option>
							<option value="양천구">양천구</option>
							<option value="영등포구">영등포구</option>
							<option value="용산구">용산구</option>
							<option value="은평구">은평구</option>
							<option value="종로구">종로구</option>
							<option value="중구">중구</option>
							<option value="중랑구">중랑구</option>
						</select>
					</div>
					<div class="col-lg-2 col-xl-2 col-md-2 col-sm-2 col-xs-2 "
						id="dropbox">
						<select class="form-control" id="crew_condition" name="order">
							<option value="">조건</option>
							<option value="new">최신순</option>
							<option value="old">오래된순</option>
						</select>
					</div>
					<div class="col-lg-2 col-xl-2 col-md-2 col-sm-2 col-xs-2"
						id="dropbox">
						<select class="form-control" id="crew_category"
							name="crew_category">
							<option value="">종류</option>
							<option value="걷기/체육">걷기/체육</option>
							<option value="친목/모임">친목/모임</option>
							<option value="문화/창작/예술">문화/창작/예술</option>
						</select>
					</div>

				</div>
				<div class="form-group">
					<div class="col-md-12 col-sm-12 col-xs-12 btn_se">
						<button type='reset' class="btn btn-primary pull-right" id="btn1"
							onClick="location.href='${pageContext.request.contextPath}/commPage/comm_crew_est.do'">크루개설</button>

						<button type="reset" class="btn btn-primary pull-right" id="btn2"
							onClick="location.href='${pageContext.request.contextPath}/commPage/comm_crew_myCrew.do'">마이크루</button>
					</div>
				</div>
			</form>
			<!-- 본문상단 끝 -->

			<div class="crew_middle">
				<div class="best">

					<!-- 크루 본문영역 중단 -->
					<c:choose>
						<%--조회결과가 없는 경우 --%>
						<c:when test="${output==null || fn:length(output) == 0} ">
							<div class="null">
								<div align="center">조회결과가 없습니다.</div>
							</div>
						</c:when>
						<%--조회결과가 있는 경우  --%>
						<c:otherwise>
							<%-- 조회 결과에 따른 반복 처리 --%>
							<c:forEach var="item" items="${output}" varStatus="status">
								<%-- 출력을 위해 준비한 크루이름 변수  --%>
								<c:set var="crew_name" value="${item.crew_name}" />

								<%-- 검색어가 있다면? --%>
								<c:if test="${keyword != '' }">
									<%-- 검색어에 <mark> 적용 --%>
									<c:set var="mark" value="<mark>${keyword}</mark>" />
									<%--출력을 위해 크루 이름에서 검색어와 일치하는 단어를 형광펜 효과 --%>
									<c:set var="crew_name"
										value="${fn:replace(crew_name,keyword,mark)}" />

								</c:if>

								<%-- 상세페이지로 이동하기위한 URL --%>
								<c:url value="/commPage/comm_crew_info.do" var="infoUrl">
									<c:param name="crew_no" value="${item.crew_no}" />
									<c:param name="crew_name" value="${item.crew_name}" />
								</c:url>
								<div class="col-xs-6 col-sm-4 col-md-3">
									<div class="thumbnail item"
										onclick="location.href='${infoUrl}'" style="cursor: pointer;">
										<img alt="크루 이미지" src="${item.crew_photo.fileUrl}"
											onclick="location.href='${infoUrl}'" style="cursor: pointer;">
										<div class="caption clearfix">
											<p>${item.crew_name}크루</p>
											<h4 class="explan">${item.crew_sinto}</h4>
											<p class="pull-left" style="max-width: 70%;">${item.crew_area}</p>
											<p class="pull-right" style="max-width: 30%;">
												${item.crew_category}</p>
										</div>
									</div>
								</div>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
			</div>



		</div>


	</div>
	<br>
	<!-- 페이지네이션 -->
	<div class="text-center">
		<!-- 페이지 번호 구현 -->
		<ul class="pagination">
			<%-- 이전 그룹에 대한 링크 --%>
			<c:choose>
				<%-- 이전 그룹으로 이동 가능하다면? --%>
				<c:when test="${pageData.prevPage > 0}">
					<%-- 이동할 URL 생성 --%>
					<c:url value="${getList }" var="prevPageUrl">
						<c:param name="keyword" value="${keyword}" />
						<c:param name="page" value="${pageData.prevPage}" />

					</c:url>
					<li class="page-item"><a href="${prevPageUrl}">&laquo;</a></li>
				</c:when>
			</c:choose>

			<%-- 페이지 번호 (시작 페이지 부터 끝 페이지까지 반복) --%>
			<c:forEach var="i" begin="${pageData.startPage}"
				end="${pageData.endPage}" varStatus="status">
				<%-- 이동할 URL 생성 --%>
				<c:url value="${getList }" var="pageUrl">
					<c:param name="keyword" value="${keyword}" />
					<c:param name="page" value="${i}" />

				</c:url>

				<%-- 페이지 번호 출력 --%>
				<c:choose>
					<%-- 현재 머물고 있는 페이지 번호를 출력할 경우 링크 적용 안함 --%>
					<c:when test="${pageData.nowPage == i}">
						<li class="page-item active"><span style="color: #fff;">${i}<span
								class="sr-only">(current)</span></span></li>
					</c:when>
					<%-- 나머지 페이지의 경우 링크 적용함 --%>
					<c:otherwise>
						<li class="page-item"><a href="${pageUrl}">${i}</a></li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<%-- 다음 그룹에 대한 링크 --%>
			<c:choose>
				<%-- 다음 그룹으로 이동 가능하다면? --%>
				<c:when test="${pageData.nextPage > 0}">
					<%-- 이동할 URL 생성 --%>
					<c:url value="${getList }" var="nextPageUrl">
						<c:param name="keyword" value="${keyword}" />
						<c:param name="page" value="${pageData.nextPage}" />

					</c:url>
					<li class="page-item"><a href="${nextPageUrl}">&raquo;</a></li>
				</c:when>
			</c:choose>
		</ul>
	</div>
	<!-- //페이지네이션 -->
	<!-- 본문하단 끝 -->

	<!-- 하단 영역 -->
	<%@ include file="/WEB-INF/views/inc/Footer.jsp"%>
	<%@ include file="/WEB-INF/views/inc/plugin.jsp"%>

</body>
</html>