<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
<style>
	/* ===== 로그인 페이지 (박스형 중앙 정렬) ===== */
	.login-container {
	  display: flex;
	  justify-content: center;
	  align-items: center;
	  height: calc(100vh - 120px); /* 상단바 + 푸터 제외 */
	  padding: 20px;
	}
	
	.login-box {
	  width: 350px;
	  background: #fff;
	  border: 1px solid #ddd;
	  border-radius: 12px;
	  padding: 30px 25px;
	  box-shadow: 0 4px 8px rgba(0,0,0,0.05);
	  text-align: center;
	}
	
	.login-box h2 {
	  margin-bottom: 20px;
	  font-size: 22px;
	  font-weight: 600;
	  color: #333;
	}
	
	.form-group {
	  margin-bottom: 15px;
	  text-align: left;
	}
	
	.form-group label {
	  display: block;
	  font-size: 14px;
	  margin-bottom: 5px;
	  color: #555;
	}
	
	.form-group input {
	  width: 100%;
	  padding: 10px;
	  border: 1px solid #ccc;
	  border-radius: 6px;
	  font-size: 14px;
	  box-sizing: border-box;
	}
	
	.form-group input:focus {
	  border-color: #6c63ff;
	  outline: none;
	}
	
	/* 로그인 버튼 */
	.btn-submit {
	  width: 100%;
	  padding: 10px;
	  background: #6c63ff;
	  border: none;
	  border-radius: 6px;
	  font-size: 15px;
	  font-weight: 600;
	  color: #fff;
	  cursor: pointer;
	  transition: background 0.2s;
	  margin-top: 10px;
	}
	
	.btn-submit:hover {
	  background: #5a54d1;
	}
	
	/* 에러 메시지 */
	.login-box .error-msg {
	  margin-top: 10px;
	  font-size: 14px;
	  color: #e74c3c;  /* 빨간색 */
	  font-weight: 500;
	  text-align: center;
	}
	
	/* 회원가입 안내 */
	.join-link {
	  margin-top: 15px;
	  font-size: 14px;
	  color: #666;
	}
	
	.join-link a {
	  color: #6c63ff;
	  text-decoration: none;
	  font-weight: 500;
	}
	
	.join-link a:hover {
	  text-decoration: underline;
	}
	</style>
	
	
</head>
<body>
	<div class="container">
		<!-- 왼쪽 사이드바 -->
		<jsp:include page="/WEB-INF/inc/sidebar.jsp" />

		<main class="main">
			<!-- 상단 네비게이션 -->
			<jsp:include page="/WEB-INF/inc/nav.jsp" />

			<!-- 메인 컨텐츠 -->
			<section class="content">
				<div class="login-container">
					<div class="login-box">
						<h2>로그인</h2>
						<form action="<c:url value='/login'/>" method="post">
							<div class="form-group">
								<label>아이디</label> <input type="text" name="memId" required>
							</div>
							<div class="form-group">
								<label>비밀번호</label> <input type="password" name="memPass"
									required>
							</div>
							<button type="submit" class="btn-submit">로그인</button>
						</form>

						<c:if test="${not empty error}">
							<p style="color: red;">${error}</p>
						</c:if>

						<p class="join-link">
							아직 회원이 아니신가요? <a href="<c:url value='/join'/>">회원가입</a>
						</p>
					</div>
				</div>
			</section>
		</main>
	</div>

	<!-- 푸터 -->
	<jsp:include page="/WEB-INF/inc/footer.jsp" />
</body>
</html>
