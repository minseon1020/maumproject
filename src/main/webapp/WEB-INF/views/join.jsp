<%@ page contentType="text/html;charset=UTF-8" language="java" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<html lang="ko">

		<head>
			<meta charset="UTF-8">
			<title>회원가입</title>
			<link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
			<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
			<style>
				/*회원가입*/
				.join-container {
					display: flex;
					justify-content: center;
					align-items: center;
					padding: 20px 0;
				}

				.join-box {
					width: 700px;
					background: #fff;
					border-radius: 12px;
					padding: 30px 40px;
					/* 		    box-shadow: 0 4px 12px rgba(0,0,0,0.08); */

				}

				.join-box h2 {
					margin-bottom: 10px;
					font-size: 22px;
					text-align: center;
				}

				.join-box p {
					margin-bottom: 20px;
					font-size: 14px;
					text-align: center;
					color: #666;
				}

				.form-group {
					margin-bottom: 15px;
				}

				.form-group label {
					display: block;
					font-size: 14px;
					font-weight: 600;
					margin-bottom: 5px;
				}

				.form-group input {
					width: 100%;
					padding: 10px;
					border: 1px solid #ddd;
					border-radius: 8px;
					font-size: 14px;
				}

				.form-check {
					margin: 10px 0;
					font-size: 13px;
					color: #444;
				}

				.btn-submit {
					width: 100%;
					padding: 12px;
					background: #6c63ff;
					border: none;
					border-radius: 8px;
					font-size: 15px;
					color: #fff;
					font-weight: bold;
					cursor: pointer;
					margin-top: 15px;
				}

				.btn-submit:hover {
					background: #574fd6;
				}

				.login-link {
					margin-top: 15px;
					text-align: center;
					font-size: 13px;
				}

				.login-link a {
					color: #6c63ff;
					font-weight: bold;
					text-decoration: none;
				}

				/*회원가입 유효성검사*/
				input.invalid {
					border-color: #e74c3c;
				}

				input.valid {
					border-color: #2ecc71;
				}

				small {
					font-size: 12px;
					display: block;
					margin-top: 5px;
				}

				.btn-submit {
					width: 100%;
					padding: 12px;
					background: #6c63ff;
					border: none;
					border-radius: 8px;
					color: #fff;
					font-weight: bold;
					cursor: pointer;
				}

				.btn-submit:hover {
					background: #574fd6;
				}
			</style>
		</head>

		<body>
			<div class="container">

				<!-- 사이드바 -->
				<jsp:include page="/WEB-INF/inc/sidebar.jsp" />

				<main class="main">
					<!-- 상단 네비바 -->
					<jsp:include page="/WEB-INF/inc/nav.jsp" />

					<!-- 콘텐츠 영역 -->
					<section class="content">
						<div class="join-container">
							<div class="join-box">
								<h2>회원가입</h2>
								<p>새 계정을 생성하여 서비스를 이용하세요.</p>

								<form id="joinForm" action="/join" method="post">
									<div class="form-group">
										<label>아이디</label>
										<div style="display:flex; gap:10px;">
											<input type="text" name="memId" id="memId" placeholder="아이디를 입력해주세요"
												required style="flex:1;">
											<button type="button" id="btnCheckId"
												style="width: 100px; padding: 10px; background: #6c63ff; color: white; border: none; border-radius: 8px; cursor: pointer; font-size:13px; font-weight:bold;">중복확인</button>
										</div>
										<span id="idCheckMsg"
											style="font-size: 13px; margin-top: 5px; display: block;"></span>
									</div>

									<div class="form-group">
										<label>비밀번호</label>
										<input type="password" name="memPass" id="password" placeholder="비밀번호를 입력해주세요"
											required>
										<small id="password-msg"></small>
									</div>

									<div class="form-group">
										<label>비밀번호 확인</label>
										<input type="password" id="passwordConfirm" placeholder="비밀번호를 다시 입력해주세요"
											required>
										<small id="passwordConfirm-msg"></small>
									</div>

									<div class="form-group">
										<label>이름</label>
										<input type="text" name="memName" placeholder="이름을 입력해주세요" required>
									</div>

									<div class="form-group">
										<label>휴대폰 번호</label>
										<input type="text" name="memHp" placeholder="010-1234-5678">
									</div>

									<div class="form-group">
										<label>생년월일</label>
										<input type="date" name="memBir">
									</div>

									<div class="form-group">
										<label>이메일</label>
										<input type="email" name="memMail" placeholder="이메일을 입력해주세요" required>
									</div>

									<button type="submit" class="btn-submit">회원가입</button>
								</form>


								<p class="login-link">이미 계정이 있으신가요? <a href="<c:url value='/login'/>">로그인</a></p>
							</div>
						</div>
					</section>
				</main>
			</div>
			<!-- footer -->
			<jsp:include page="/WEB-INF/inc/footer.jsp" />
			<script>
				document.addEventListener("DOMContentLoaded", function () {
					const form = document.getElementById("joinForm");
					const password = document.getElementById("password");
					const passwordConfirm = document.getElementById("passwordConfirm");
					const passwordMsg = document.getElementById("password-msg");
					const passwordConfirmMsg = document.getElementById("passwordConfirm-msg");

					let isIdChecked = false; // 아이디 중복확인 여부

					// 아이디 중복확인 버튼 클릭
					$("#btnCheckId").click(function () {
						let memId = $("#memId").val();
						if (memId == "") {
							alert("아이디를 입력해주세요.");
							return;
						}

						$.ajax({
							url: "/checkId",
							type: "POST",
							data: { memId: memId },
							success: function (res) {
								if (res === "OK") {
									$("#idCheckMsg").text("사용 가능한 아이디입니다.").css("color", "green");
									isIdChecked = true;
								} else {
									$("#idCheckMsg").text("이미 사용중인 아이디입니다.").css("color", "red");
									isIdChecked = false;
								}
							},
							error: function () {
								alert("중복 확인 중 오류가 발생했습니다.");
							}
						});
					});

					// 아이디 변경 시 중복확인 초기화
					$("#memId").on("input", function () {
						isIdChecked = false;
						$("#idCheckMsg").text("");
					});

					// 비밀번호 길이 검사 (8~12자)
					function checkPassword() {
						if (password.value.length < 8 || password.value.length > 12) {
							passwordMsg.textContent = "비밀번호는 8~12자리여야 합니다.";
							passwordMsg.style.color = "red";
							return false;
						} else {
							passwordMsg.textContent = "사용 가능한 비밀번호입니다.";
							passwordMsg.style.color = "green";
							return true;
						}
					}

					// 비밀번호 확인 검사
					function checkPasswordConfirm() {
						if (passwordConfirm.value !== password.value || passwordConfirm.value === "") {
							passwordConfirmMsg.textContent = "비밀번호가 일치하지 않습니다.";
							passwordConfirmMsg.style.color = "red";
							return false;
						} else {
							passwordConfirmMsg.textContent = "비밀번호가 일치합니다.";
							passwordConfirmMsg.style.color = "green";
							return true;
						}
					}

					// 이벤트 등록
					password.addEventListener("input", checkPassword);
					passwordConfirm.addEventListener("input", checkPasswordConfirm);

					// 제출 검사
					form.addEventListener("submit", function (e) {
						if (!isIdChecked) {
							e.preventDefault();
							alert("아이디 중복확인을 해주세요!");
							return;
						}

						if (!checkPassword() || !checkPasswordConfirm()) {
							e.preventDefault();
							alert("비밀번호 조건을 확인해주세요!");
						}
					});
				});

			</script>
			<script>
				/* 서버에서 에러 메시지가 오면 알림창 띄우기 */
				<c:if test="${not empty error}">
					alert("${error}");
				</c:if>
			</script>
		</body>

		</html>