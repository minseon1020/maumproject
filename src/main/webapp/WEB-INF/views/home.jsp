<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <html lang="ko">

        <head>
            <meta charset="UTF-8">
            <title>홈 화면</title>
            <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">

            <!-- Chart.js -->
            <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
            <!-- FullCalendar -->
            <link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.css" rel="stylesheet" />
            <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>
            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

            <style>
                .content {
                    display: grid;
                    grid-template-columns: 2fr 1fr 2fr;
                    gap: 30px;
                    padding: 30px;
                }

                .card {
                    background: #fff;
                    border: 1px solid #eee;
                    border-radius: 10px;
                    padding: 15px;
                    margin-bottom: 15px;
                    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
                }

                .card h3 {
                    margin-bottom: 10px;
                    font-size: 16px;
                }

                .tab-buttons {
                    margin: 10px 0;
                    display: flex;
                    justify-content: center;
                    gap: 10px;
                }

                .tab-buttons button {
                    padding: 8px 18px;
                    border: 1px solid #ddd;
                    border-radius: 6px;
                    background: #f5f5f5;
                    cursor: pointer;
                    font-size: 14px;
                }

                .tab-buttons button.active {
                    background: #4a6cf7;
                    color: #fff;
                    border-color: #4a6cf7;
                    font-weight: 600;
                }

                .filter-area {
                    text-align: center;
                    margin: 10px 0;
                }

                .emotion-buttons button {
                    margin: 5px;
                    padding: 8px 12px;
                    border-radius: 8px;
                    border: none;
                    cursor: pointer;
                }

                .alert-box {
                    margin-top: 15px;
                    padding: 10px;
                    border-radius: 6px;
                    background-color: #ffecec;
                    border: 1px solid #ff6b6b;
                    color: #b22222;
                    display: none;
                }

                /*  모달 스타일 */
                /*첫 화면 모달 숨기기*/
                #memoModal {
                    display: none;
                    /*  기본값 숨김 */
                    position: fixed;
                    top: 0;
                    left: 0;
                    width: 100%;
                    height: 100%;
                    background: rgba(0, 0, 0, 0.5);
                    align-items: center;
                    justify-content: center;
                    z-index: 9999;
                }

                #memoModal .modal-content {
                    background: #fff;
                    padding: 20px;
                    border-radius: 10px;
                    width: 300px;
                    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
                }

                #memoModal h3 {
                    margin-top: 0;
                }

                #memoModal input {
                    width: 100%;
                    padding: 8px;
                    border: 1px solid #ddd;
                    border-radius: 6px;
                }

                #memoModal .btn-area {
                    margin-top: 15px;
                    text-align: right;
                }
            </style>
        </head>

        <body>
            <div class="container">
                <jsp:include page="/WEB-INF/inc/sidebar.jsp" />

                <main class="main">
                    <jsp:include page="/WEB-INF/inc/nav.jsp" />

                    <!-- 콘텐츠 영역 -->
                    <section class="content">
                        <!-- 달력 -->
                        <div class="card">
                            <h3>일기 달력</h3>
                            <div id="calendar"></div>
                        </div>

                        <!-- 오늘의 감정 체크 -->
                        <div class="card">
                            <h3>오늘의 감정 체크</h3>
                            <p><b>지금 기분을 기록해보세요</b></p>
                            <p>하루에 여러 번 눌러도 됩니다. 기록은 통계에 반영됩니다.</p>

                            <div class="emotion-buttons">
                                <button class="emotion-btn" data-emotion="1" data-label="😊 Happy">😊 Happy</button>
                                <button class="emotion-btn" data-emotion="2" data-label="😌 Calm">😌 Calm</button>
                                <button class="emotion-btn" data-emotion="3" data-label="😟 Anxious">😟 Anxious</button>
                                <button class="emotion-btn" data-emotion="4" data-label="😢 Sad">😢 Sad</button>
                                <button class="emotion-btn" data-emotion="5" data-label="😡 Angry">😡 Angry</button>
                                <button class="emotion-btn" data-emotion="6" data-label="🥱 Tired">🥱 Tired</button>
                            </div>
                        </div>

                        <!-- 감정 통계 보고서 -->
                        <div class="card">
                            <h3>감정 보고서</h3>
                            <div class="tab-buttons">
                                <button onclick="setActiveTab(this); loadChart('day')">오늘</button>
                                <button class="active" onclick="setActiveTab(this); loadChart('week')">주별</button>
                                <button onclick="setActiveTab(this); loadChart('month')">월별</button>
                                <button onclick="setActiveTab(this); loadChart('time-block')">시간대별</button>
                            </div>

                            <!-- 선택 필터 (시간대별만 표시) -->
                            <div class="filter-area">
                                <input type="date" id="timeBlockDate" style="display:none;"
                                    onchange="loadChart('time-block', this.value)">
                            </div>
                            <div class="filter-area">
                                <input type="date" id="timeBlockDate" style="display:none;"
                                    onchange="loadChart('time-block', this.value)">
                                <input type="month" id="monthSelect" style="display:none;"
                                    onchange="loadChart('month', this.value)">
                            </div>

                            <canvas id="emotionChart"></canvas>

                            <div id="counselingAlert" class="alert-box">
                                최근 한 달 동안 부정적인 감정이 가장 많이 기록되었습니다.<br>
                                마음이 힘들다면 <b><a href="/center" style="color:red;">상담센터</a></b>를 이용해 보세요.
                            </div>
                        </div>
                    </section>
                </main>
            </div>

            <jsp:include page="/WEB-INF/inc/footer.jsp" />

            <!--  메모 입력 모달 -->
            <div id="memoModal">
                <div class="modal-content">
                    <h3 id="modalTitle">메모 입력</h3>
                    <input type="text" id="modalMemo" placeholder="메모를 입력하세요">
                    <div class="btn-area">
                        <button onclick="closeModal()">취소</button>
                        <button id="saveMemoBtn">저장</button>
                    </div>
                </div>
            </div>

            <script>
                let chartInstance = null;
                let memId = "<c:out value='${loginUser.memId}' default='guest'/>";

                if (memId === "guest") {
                    alert("로그인이 필요합니다. 로그인 후 이용해주세요.");
                    window.location.href = "/login";
                }

                function setActiveTab(button) {
                    document.querySelectorAll('.tab-buttons button').forEach(btn => btn.classList.remove('active'));
                    button.classList.add('active');
                }

                // 차트 불러오기
                function loadChart(period, date = null) {
                    let url = "";

                    document.getElementById("timeBlockDate").style.display =
                        (period === "time-block") ? "inline-block" : "none";

                    if (period === "time-block") {
                        const targetDate = date || new Date().toISOString().split("T")[0];
                        document.getElementById("timeBlockDate").value = targetDate;
                        url = `/emotion/stats/time-block?memId=\${memId}&date=\${targetDate}`;
                    } else if (period === "week") {
                        url = `/emotion/stats/weekly?memId=\${memId}`;
                    } else if (period === "month") {
                        url = `/emotion/stats/monthly?memId=\${memId}`;
                    } else if (period === "day") {
                        url = `/emotion/stats/daily?memId=\${memId}`;
                    } else {
                        url = `/emotion/stats/daily?memId=\${memId}`;
                    }

                    $.get(url, function (data) {
                        let labels = [], datasets = [];

                        if (period === "month") {
                            let negativeList = ["Sad", "Angry", "Tired", "Anxious"];
                            let negSum = 0, posSum = 0;
                            data.forEach(item => {
                                if (negativeList.includes(item.emotionName)) negSum += item.emotionCount;
                                else posSum += item.emotionCount;
                            });
                            let total = negSum + posSum;
                            document.getElementById("counselingAlert").style.display =
                                (total >= 5 && (negSum / total) >= 0.5) ? "block" : "none";
                        } else {
                            document.getElementById("counselingAlert").style.display = "none";
                        }

                        if (period === "time-block") {
                            labels = ["00-06", "06-12", "12-18", "18-24"];
                            let emotions = [...new Set(data.map(item => item.emotionName))];
                            datasets = emotions.map((emotion, idx) => ({
                                label: emotion,
                                data: labels.map(block => {
                                    let rec = data.find(d => d.timeBlock === block && d.emotionName === emotion);
                                    return rec ? rec.emotionCount : 0;
                                }),
                                backgroundColor: ['#FFD700', '#87CEEB', '#FFB6C1', '#1E90FF', '#FF6347', '#D3D3D3'][idx % 6]
                            }));
                        } else {
                            labels = data.map(item => item.emotionName);
                            let counts = data.map(item => item.emotionCount);
                            datasets = [{
                                label: "감정 횟수",
                                data: counts,
                                backgroundColor: ['#FFD700', '#87CEEB', '#FFB6C1', '#1E90FF', '#FF6347', '#D3D3D3']
                            }];
                        }

                        let ctx = document.getElementById('emotionChart').getContext('2d');
                        if (chartInstance) chartInstance.destroy();

                        chartInstance = new Chart(ctx, {
                            type: (period === "day") ? "pie" : "bar",
                            data: { labels: labels, datasets: datasets },
                            options: {
                                responsive: true,
                                plugins: { legend: { display: true, position: 'top' } },
                                scales: (period === "time-block")
                                    ? { x: { stacked: true }, y: { stacked: true, beginAtZero: true } }
                                    : { y: { beginAtZero: true } }
                            }
                        });
                    });
                }

                //  모달 동작
                let selectedEmotionId = null;
                let selectedEmotionLabel = "";

                $(".emotion-btn").click(function () {
                    selectedEmotionId = $(this).data("emotion");
                    selectedEmotionLabel = $(this).data("label");

                    document.getElementById("modalTitle").innerText = selectedEmotionLabel + " 메모 입력";
                    document.getElementById("memoModal").style.display = "flex";
                });

                function closeModal() {
                    document.getElementById("memoModal").style.display = "none";
                    $("#modalMemo").val("");
                }

                $("#saveMemoBtn").click(function () {
                    let memo = $("#modalMemo").val();

                    $.ajax({
                        url: "/emotion/click",
                        type: "POST",
                        contentType: "application/json",
                        data: JSON.stringify({
                            memId: memId,
                            emotionId: selectedEmotionId,
                            memo: memo
                        }),
                        success: function () {
                            alert("감정이 저장되었습니다 ");
                            closeModal();

                            const activeText = document.querySelector('.tab-buttons button.active').textContent;
                            const currentPeriod = activeText.includes("오늘") ? "day"
                                : activeText.includes("주별") ? "week"
                                    : activeText.includes("월별") ? "month"
                                        : "time-block";
                            loadChart(currentPeriod);
                        },
                        error: function (xhr) {
                            alert(" 감정 저장 실패\n" + xhr.responseText);
                        }
                    });
                });

                // 초기화
                document.addEventListener("DOMContentLoaded", function () {
                    loadChart('week');

                    var events = [];
                    <c:forEach items="${diaryList}" var="diary">
                        events.push({id: "${diary.dId}", title: "${diary.title}", start: "${diary.diaryDate}" });
                    </c:forEach>

                    var calendar = new FullCalendar.Calendar(document.getElementById('calendar'), {
                        initialView: 'dayGridMonth',
                        locale: 'ko',
                        height: 600,
                        events: events,
                        eventClick: function (info) {
                            window.location.href = "/diary/view?dId=" + info.event.id;
                        },
                        dateClick: function (info) {
                            window.location.href = "/diary/write?date=" + info.dateStr;
                        }
                    });

                    calendar.render();
                });
            </script>
        </body>

        </html>