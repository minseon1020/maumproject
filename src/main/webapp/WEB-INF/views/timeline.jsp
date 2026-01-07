<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>감정 타임라인</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        .timeline-wrapper {
            width: 80%;   /* 화면 거의 꽉 차게 */
            margin: 30px auto;
        }
        h2 { margin-bottom:10px; }
        .date-picker { 
            margin-bottom:20px; 
            text-align: left; 
        }
        /* ✅ 날짜 input & 버튼 스타일 */
        .date-picker input[type="date"] {
            padding: 10px 14px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }
        .date-picker button {
            padding: 10px 18px;
            font-size: 16px;
            margin-left: 6px;
            border: none;
            border-radius: 6px;
            background: #4a6cf7;
            color: white;
            cursor: pointer;
        }
        .date-picker button:hover {
            background: #3958d7;
        }

        .timeline-content {
            display: flex;
            gap: 30px;
            align-items: flex-start;
        }
        .timeline-left {
            flex: 9; /* 표 크게 */
        }
        .timeline-right {
            flex: 3; /* 차트 작게 */
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: center;
            font-size: 15px;
        }
        th {
            background: #f5f5f5;
            font-weight: bold;
        }
        /* ✅ 표 열 너비 조정 */
        th.time-col, td.time-col { width: 100px; }
        th.emotion-col, td.emotion-col { width: 150px; }
        th.memo-col, td.memo-col { width: auto; } /* 메모는 남은 영역 다 사용 */
        .no-records {
            text-align: center;
            padding: 20px;
            color: #777;
        }
    </style>
</head>
<body>
<div class="container">
    <jsp:include page="/WEB-INF/inc/sidebar.jsp" />

    <main class="main">
        <jsp:include page="/WEB-INF/inc/nav.jsp" />

        <section class="timeline-wrapper">
            <h2>감정 타임라인</h2>

            <!-- ✅ 제목 아래 날짜 선택 -->
            <div class="date-picker">
                <form method="get" action="/emotion/timeline">
                    <input type="date" name="date" value="${date}">
                    <button type="submit">조회</button>
                </form>
            </div>

            <div class="timeline-content">
                <!-- 표 -->
                <div class="timeline-left">
                    <table>
                        <thead>
                            <tr>
                                <th class="time-col">시간</th>
                                <th class="emotion-col">감정</th>
                                <th class="memo-col">메모</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${empty logs}">
                                <tr>
                                    <td colspan="3" class="no-records">📭 기록 없음</td>
                                </tr>
                            </c:if>
                            <c:forEach var="log" items="${logs}">
                                <tr>
                                    <td class="time-col">${log.logTime}</td>
                                    <td class="emotion-col">${log.emotionName}</td>
                                    <td class="memo-col">
                                        <c:choose>
                                            <c:when test="${not empty log.memo}">${log.memo}</c:when>
                                            <c:otherwise>-</c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- 차트 -->
                <div class="timeline-right">
                    <h3>📊 ${date} 감정 비율</h3>
                    <canvas id="timelineChart"></canvas>
                </div>
            </div>
        </section>
    </main>
</div>

<jsp:include page="/WEB-INF/inc/footer.jsp" />

<script>
document.addEventListener("DOMContentLoaded", function() {
    let logs = [
        <c:forEach var="log" items="${logs}" varStatus="st">
            { emotionName: "${log.emotionName}" }
            <c:if test="${!st.last}">,</c:if>
        </c:forEach>
    ];

    let counts = {};
    logs.forEach(l => {
        counts[l.emotionName] = (counts[l.emotionName] || 0) + 1;
    });

    let labels = Object.keys(counts);
    let data = Object.values(counts);

    if (labels.length > 0) {
        let ctx = document.getElementById("timelineChart").getContext("2d");
        new Chart(ctx, {
            type: "pie",
            data: {
                labels: labels,
                datasets: [{
                    data: data,
                    backgroundColor: [
                        '#FFD700','#87CEEB','#FFB6C1',
                        '#1E90FF','#FF6347','#D3D3D3'
                    ]
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: { position: 'bottom' }
                }
            }
        });
    }
});
</script>
</body>
</html>
