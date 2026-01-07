<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>새 일기 작성</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
    <style>
			/* ===== 일기 작성 ===== */
	.card {
	  background: #fff;
	  padding: 20px 30px;
	  margin: 0 auto;
	  max-width: 80%; /* 가로 꽉 차게 */
	}
	
	.card h2 {
	  margin-bottom: 20px;
	  font-size: 24px;
	  font-weight: 600;
	  color: #333;
	}
	
	/* 제목 입력 */
	.card input[type="text"] {
	  width: 100%;
	  padding: 14px;
	  border: 1px solid #ccc;
	  border-radius: 6px;
	  font-size: 16px;
	  margin-bottom: 20px;
	  box-sizing: border-box;
	  transition: border 0.2s, box-shadow 0.2s;
	}
	
	.card input[type="text"]:focus {
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
	
	/* 내용 입력 칸 - 화면 거의 꽉 차게 */
	.card textarea {
	  width: 100%;
	  min-height: 60vh; /* 세로 화면의 60% 정도 차지 */
	  padding: 14px;
	  border: 1px solid #ccc;
	  border-radius: 6px;
	  font-size: 15px;
	  line-height: 1.6;
	  resize: vertical;
	  box-sizing: border-box;
	  transition: border 0.2s, box-shadow 0.2s;
	}
	
	.card textarea:focus {
	  border-color: #4a6cf7;
	  box-shadow: 0 0 0 2px rgba(74,108,247,0.2);
	  outline: none;
	}
	
	/* 버튼 */
	.form-buttons {
	  text-align: right;
	  margin-top: 20px;
	  display: flex;
	  justify-content: flex-end;
	  gap: 12px;
	}
	
	.btn {
	  padding: 10px 20px;
	  border-radius: 6px;
	  font-size: 15px;
	  font-weight: 500;
	  cursor: pointer;
	  border: none;
	  transition: background 0.2s;
	}
	
	
	/* 저장 버튼 */
	.btn.primary {
	  background: #4a6cf7;
	  color: #fff;
	}
	
	.btn.primary:hover {
	  background: #3451c9;
	}
			
	</style>
</head>
<body>
<div class="container">

    <!-- 사이드바 -->
    <jsp:include page="/WEB-INF/inc/sidebar.jsp" />

    <main class="main">
        <!-- 네비바 -->
        <jsp:include page="/WEB-INF/inc/nav.jsp" />

        <!-- 콘텐츠 영역 -->
        <section class="content">
            <div class="card">
                <h2>✍️ 새 일기 작성</h2>

                <!-- 저장 요청: POST /diary/save -->
                <form action="<c:url value='/diary/save'/>" method="post">
                    <!-- 제목 -->
					<input type="hidden" name="memId" value="a001" >                    
                    <div>
                        <label>제목</label>
                        <input type="text" name="title" placeholder="제목 없는 일기">
                    </div>

                    <!-- 날짜 (달력에서 클릭한 값이 표시됨) -->
                    <p>${date}</p>
                    <input type="hidden" name="diaryDate" value="${date}">

                    <!-- 내용 -->
                    <div>
                        <textarea name="cContent" rows="10" cols="50"
                                  placeholder="여기에 당신의 일기를 자유롭게 작성하세요..."></textarea>
                    </div>

                    <!-- 버튼 -->
                    <div class="form-buttons">                      
                        <button type="submit" class="btn primary">일기 저장</button>
                    </div>
                </form>
            </div>
        </section>
    </main>
</div>

<!-- 푸터 -->
<jsp:include page="/WEB-INF/inc/footer.jsp" />
</body>
</html>
