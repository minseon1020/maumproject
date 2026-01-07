<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>상담센터</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <!--  카카오 지도 SDK : 반드시 제일 위에!! -->
    <script type="text/javascript"
            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=326e8a44dd244edd76042073544c20e8&libraries=services,clusterer"></script>

    <style>
        /* ===== 상담센터 전용 스타일 ===== */
        .center-content { padding: 0; }

        .map_wrap {
          position: relative;
          width: 100%;
          height: 60vh;
          margin: 0 auto;
          border-radius: 8px;
          overflow: hidden;
          box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        #map { width: 100%; height: 100%; }

        #menu_wrap {
          position: absolute;
          top: 15px;
          left: 15px;
          width: 280px;
          max-height: 80%;
          overflow-y: auto;
          background: #fff;
          border-radius: 8px;
          box-shadow: 0 2px 8px rgba(0,0,0,0.15);
          padding: 12px;
          font-size: 14px;
          z-index: 10;
        }
        #menu_wrap::-webkit-scrollbar { width: 6px; }
        #menu_wrap::-webkit-scrollbar-thumb { background: #ccc; border-radius: 3px; }

        #menu_wrap .option { display: flex; gap: 6px; margin-bottom: 10px; }
        #menu_wrap input[type="text"] {
          flex: 1; padding: 6px 10px; border: 1px solid #ccc; border-radius: 6px; font-size: 13px;
        }
        #menu_wrap button {
          padding: 6px 12px; border: none; border-radius: 6px;
          background: #4a6cf7; color: #fff; font-size: 13px; cursor: pointer;
          transition: background 0.2s;
        }
        #menu_wrap button:hover { background: #3451c9; }

        #placesList { list-style: none; padding: 0; margin: 0; }
        #placesList li {
          padding: 10px; border-bottom: 1px solid #eee;
          cursor: pointer; transition: background 0.2s;
        }
        #placesList li:hover { background: #f7f7f7; }
        #placesList b { font-size: 14px; color: #333; }
    </style>
</head>
<body>
<div class="container">
    <jsp:include page="/WEB-INF/inc/sidebar.jsp" />

    <main class="main">
        <jsp:include page="/WEB-INF/inc/nav.jsp" />

        <!-- 콘텐츠 영역 -->
        <section class="content center-content">
            <h2 style="padding:15px;">상담센터 안내</h2>
            <div class="map_wrap">
                <div id="map"></div>
                <div id="menu_wrap">
                    <div class="option">
                        <input type="text" id="keyword" placeholder="센터명/지역 검색" size="20"/>
                        <button type="button" id="searchBtn">검색</button>
                    </div>
                    <hr/>
                    <ul id="placesList"></ul>
                </div>
            </div>
        </section>

        <jsp:include page="/WEB-INF/inc/footer.jsp" />
    </main>
</div>

<!-- 지도/검색 스크립트 -->
<script>
    // 지도 초기화
    var mapContainer = document.getElementById('map'),
        mapOption = { center: new kakao.maps.LatLng(37.5665,126.9780), level: 7 };

    var map = new kakao.maps.Map(mapContainer, mapOption);
    var clusterer = new kakao.maps.MarkerClusterer({
        map: map, averageCenter: true, minLevel: 6
    });
    var infowindow = new kakao.maps.InfoWindow({zIndex:1});
    var ps = new kakao.maps.services.Places(); // 카카오 장소 검색 객체

    // DB 전체 센터 불러오기
    function loadAllCenters(){
        $.getJSON('<c:url value="/api/centerList"/>', function(data){
            data.forEach(d => d.type="DB");
            renderAllResults(data);
        });
    }

    // 검색 (DB + 카카오 통합)
    $("#searchBtn").click(function(){
        var query = $("#keyword").val().trim();
        if(query===""){ alert("검색어를 입력하세요!"); return; }

        var combinedResults = [];

        // 1) DB 검색
        $.getJSON('<c:url value="/api/searchCenters"/>', {keyword:query}, function(data){
            data.forEach(d => d.type="DB");
            combinedResults = combinedResults.concat(data);

            // 2) 카카오 검색
            ps.keywordSearch(query, function(kakaoData, status){
                if(status === kakao.maps.services.Status.OK){
                    kakaoData.forEach(p => {
                        combinedResults.push({
                            type:"KAKAO",
                            centerNm: p.place_name,
                            telno: p.phone,
                            roadnmAddr: p.address_name,
                            lat: p.y,
                            lng: p.x
                        });
                    });
                }

                // DB + 카카오 통합 결과 렌더링
                renderAllResults(combinedResults);
                if(combinedResults.length===0) alert("검색 결과가 없습니다.");
            });
        });
    });

    // 공통 렌더링 함수
    function renderAllResults(data){
        var listEl=document.getElementById('placesList');
        listEl.innerHTML="";
        clusterer.clear();

        var bounds=new kakao.maps.LatLngBounds();
        var newMarkers=[];

        data.forEach(function(item){
            var position=new kakao.maps.LatLng(item.lat, item.lng);
            var marker=new kakao.maps.Marker({position:position});

            kakao.maps.event.addListener(marker,'click',function(){
                infowindow.setContent("<div style='padding:5px;font-size:12px;'>"
                    + item.centerNm + "<br/>" + (item.telno||"") + "</div>");
                infowindow.open(map,marker);
            });

            var li=document.createElement("li");
            li.innerHTML="<b>"+item.centerNm+"</b><br/>"+(item.roadnmAddr||"")+
                         (item.telno ? "<br/>"+item.telno : "")+
                         (item.type==="KAKAO" ? " <span style='color:blue'>(카카오)</span>" : "");
            li.onclick=function(){
                map.setCenter(position); map.setLevel(5);
                infowindow.setContent("<div style='padding:5px;'>"+item.centerNm+"<br/>"+(item.telno||"")+"</div>");
                infowindow.open(map,marker);
            };
            listEl.appendChild(li);

            bounds.extend(position);
            newMarkers.push(marker);
        });

        clusterer.addMarkers(newMarkers);
        if(data.length>0) map.setBounds(bounds);
    }

    // 초기 실행
    $(document).ready(function(){ loadAllCenters(); });
</script>
</body>
</html>
