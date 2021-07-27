/**
 * 
 */
$(".heart").on("click",function() {
	 if($(this).hasClass("liked")) {
		$(this).html('<i class="fa fa-heart-o" aria-hidden="true"></i>');
		$(this).removeClass("liked");
	} else {
		$(this).html('<i class="fa fa-heart" aria-hidden="true"></i>');
		$(this).addClass("liked");
	}
});
var course_no = $('#delete-btn').data('mycourseno');

$("#delete-btn").on("click",function() {
		if(confirm("삭제하시겠습니까?")){
		location.href = getContextPath()+"/commPage/comm_myCourseDeleteOk.do?mycourse_no="+course_no;
		return true;
	}else{
		return false;
	}
})


var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = {
		center: new kakao.maps.LatLng(37.5160832, 126.9661696), // 지도의 중심좌표
		level: 4, // 지도의 확대 레벨
		mapTypeId: kakao.maps.MapTypeId.ROADMAP // 지도종류
	};
var course_name = $('#mycourse_name').data('mycoursename');


$(function() {
	console.log(course_name)
	map = null;
	var map = new kakao.maps.Map(mapContainer, mapOption);
	$.ajax({
		url: getContextPath() + '/commPage/comm_myCourseDetailGetLoc.do',
		type: 'post',
		data: { course_name },
		success: function(data) {
			var linepath = [];
			var lat = [];
			var lon = [];
			for (var i = 0; i < data.courseName.length; i++) {
				console.log(data.courseName[i].lat)
				console.log(data.courseName[i].lon)

				lat[i] = parseFloat(data.courseName[i].lat);
				lon[i] = parseFloat(data.courseName[i].lon);
				linepath[i] = new kakao.maps.LatLng(parseFloat(data.courseName[i].lat), parseFloat(data.courseName[i].lon));
			};
			// 지도에 선을 표시한다 
			var polyline = new kakao.maps.Polyline({
				map: map, // 선을 표시할 지도 객체 
				path: linepath,
				strokeWeight: 2, // 선의 두께
				strokeColor: '#FF0000', // 선 색
				strokeOpacity: 1, // 선 투명도
				strokeStyle: 'solid' // 선 스타일
			});
			// 지도에 마커를 생성하고 표시한다
			var marker = new kakao.maps.Marker({
				position: new kakao.maps.LatLng(lat[0], lon[0]), // 마커의 좌표
				map: map // 마커를 표시할 지도 객체
			});
			// 지도 중심 좌표 변화 이벤트를 등록한다
			kakao.maps.event.addListener(map, 'center_changed', function() {
				console.log('지도의 중심 좌표는 ' + map.getCenter().toString() + ' 입니다.');
			});
			map.setCenter(new kakao.maps.LatLng(lat[0], lon[0]));

			// 도형에 mouseover 이벤트를 등록한다 
			kakao.maps.event.addListener(polyline, 'mouseover', function() {
				console.log('도형에 mouseover 이벤트가 발생했습니다!');
			});

			// 도형에 mouseout 이벤트를 등록한다 
			kakao.maps.event.addListener(polyline, 'mouseout', function() {
				console.log('도형에 mouseout 이벤트가 발생했습니다!');
			});

			// 도형에 mousedown 이벤트를 등록한다
			kakao.maps.event.addListener(polyline, 'mousedown', function() {
				console.log('도형에 mousedown 이벤트가 발생했습니다!');
			});
		}
	});
});




