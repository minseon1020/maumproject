<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>일기 보기</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
    <style>
        /* ===== 일기 보기 / 수정 ===== */
        .card {
          background: #fff;
          padding: 20px 30px;
          margin: 0 auto;
          max-width: 80%;
        }

        .card h2 {
          margin-bottom: 20px;
          font-size: 24px;
          font-weight: 600;
          color: #333;
        }

        /* 라벨 */
        .card label {
          display: block;
          margin-bottom: 6px;
          font-size: 14px;
          font-weight: 500;
          color: #444;
        }

        /* 제목 / 작성자 */
        .card input[type="text"] {
          width: 100%;
          padding: 12px;
          border: 1px solid #ccc;
          border-radius: 6px;
          font-size: 15px;
          margin-bottom: 18px;
          box-sizing: border-box;
          transition: border 0.2s, box-shadow 0.2s;
        }

        .card input[type="text"]:focus {
          border-color: #4a6cf7;
          box-shadow: 0 0 0 2px rgba(74,108,247,0.2);
          outline: none;
        }

        /* 내용 */
        .card textarea {
          width: 100%;
          min-height: 60vh;
          padding: 12px;
          border: 1px solid #ccc;
          border-radius: 6px;
          font-size: 15px;
          line-height: 1.6;
          margin-bottom: 18px;
          box-sizing: border-box;
          resize: vertical;
          transition: border 0.2s, box-shadow 0.2s;
        }

        .card textarea:focus {
          border-color: #4a6cf7;
          box-shadow: 0 0 0 2px rgba(74,108,247,0.2);
          outline: none;
        }

        /* 날짜 */
        .card p {
          font-size: 14px;
          color: #777;
          margin: 10px 0 20px;
        }

        /* 버튼 영역 */
        .form-buttons {
          display: flex;
          justify-content: flex-end;
          gap: 10px;
          margin-top: 20px;
        }

        button {
          padding: 8px 16px;
          border-radius: 6px;
          font-size: 14px;
          font-weight: 500;
          cursor: pointer;
          border: none;
          transition: background 0.2s;
        }

        /* 수정 / 저장 버튼 */
        #editBtn, #saveBtn {
          background: #4a6cf7;
          color: #fff;
        }

        #editBtn:hover,
        #saveBtn:hover {
          background: #3451c9;
        }

        /* 취소 버튼 */
        #cancelBtn {
          background: #f0f0f0;
          color: #333;
        }

        #cancelBtn:hover {
          background: #e0e0e0;
        }

        /* 삭제 버튼 */
        .btn.danger {
          background: #e74c3c;
          color: #fff;
        }

        .btn.danger:hover {
          background: #c0392b;
        }

        /* 숨김 */
        .hidden {
          display: none;
        }
    </style>
    <script>
        // 수정 모드 켜기
        function enableEdit() {
            document.getElementById("title").removeAttribute("readonly");
            document.getElementById("cContent").removeAttribute("readonly");

            // 버튼 전환
            document.getElementById("editBtn").classList.add("hidden");
            document.getElementById("saveBtn").classList.remove("hidden");
            document.getElementById("cancelBtn").classList.remove("hidden");
        }

        // 수정 취소 → 새로고침
        function cancelEdit() {
            window.location.reload();
        }
    </script>
</head>
<body>
<div class="container">

    <!-- ✅ 사이드바 -->
    <jsp:include page="/WEB-INF/inc/sidebar.jsp" />

    <main class="main">
        <!-- ✅ 네비게이션 -->
        <jsp:include page="/WEB-INF/inc/nav.jsp" />

        <!-- ✅ 콘텐츠 영역 -->
        <section class="content">
            <div class="card">
                <h2>📖 일기 보기</h2>

                <!-- 수정/저장/삭제 폼 -->
                <form action="<c:url value='/diary/update'/>" method="post">
                    <input type="hidden" name="dId" value="${diary.dId}" />
                    <input type="hidden" name="memId" value="${diary.memId}" />

                    <div>
                        <label>작성자</label>
                        <input type="text" value="${diary.memId}" readonly />
                    </div>

                    <div>
                        <label>제목</label>
                        <input type="text" id="title" name="title" value="${diary.title}" readonly />
                    </div>

                    <div>
                        <label>내용</label>
                        <textarea id="cContent" name="cContent" rows="10" cols="50" readonly>${diary.cContent}</textarea>
                    </div>

                    <p>작성일: ${diary.diaryDate}</p>

                    <!-- 버튼 -->
                    <div class="form-buttons">
                        <!-- 보기 모드 -->
                        <button type="button" id="editBtn">수정</button>
                        <button type="submit" formaction="<c:url value='/diary/delete'/>"
                                formmethod="post" class="btn danger"
                                onclick="return confirm('정말 삭제하시겠습니까?');">
                            삭제
                        </button>

                        <!-- 수정 모드 -->
                        <button type="submit" id="saveBtn" class="hidden">저장</button>
                        <button type="button" id="cancelBtn" class="hidden">취소</button>
                    </div>
                </form>
            </div>
        </section>
    </main>
</div>

<!-- ✅ 푸터 -->
<jsp:include page="/WEB-INF/inc/footer.jsp" />

<!-- ✅ 버튼 이벤트 연결 -->
<script>
    // 수정 버튼 → 수정 모드 활성화
    document.getElementById("editBtn").addEventListener("click", enableEdit);

    // 취소 버튼 → 취소 동작 연결
    document.getElementById("cancelBtn").addEventListener("click", cancelEdit);
</script>
</body>
</html>
