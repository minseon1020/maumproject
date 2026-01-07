<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <html lang="ko">

            <head>
                <meta charset="UTF-8">
                <title>마이페이지</title>
                <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
                <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

                <style>
                    .mypage-container {
                        max-width: 800px;
                        margin: 50px auto;
                    }

                    .mypage-title {
                        text-align: center;
                        margin-bottom: 30px;
                        font-size: 24px;
                        font-weight: bold;
                    }

                    .profile-img {
                        display: block;
                        margin: 0 auto 20px;
                        border-radius: 50%;
                        width: 150px;
                        height: 150px;
                        object-fit: cover;
                        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
                        cursor: not-allowed;
                        /* 기본적으로 클릭 못 하게 */
                    }

                    .form-group {
                        margin-bottom: 15px;
                    }

                    .form-group label {
                        display: block;
                        font-weight: 600;
                        margin-bottom: 5px;
                        text-align: left;
                    }

                    .form-group input {
                        width: 100%;
                        padding: 10px;
                        border: 1px solid #ddd;
                        border-radius: 6px;
                    }

                    .form-group input[readonly] {
                        background-color: #f8f9fa;
                        cursor: not-allowed;
                    }

                    .btn-wrap {
                        display: flex;
                        justify-content: flex-end;
                        gap: 10px;
                        margin-top: 20px;
                    }

                    .btn {
                        padding: 10px 20px;
                        border: none;
                        border-radius: 6px;
                        cursor: pointer;
                        font-size: 15px;
                    }

                    .btn-primary {
                        background: #4a6cf7;
                        color: white;
                        font-weight: bold;
                    }

                    .btn-secondary {
                        background: #ddd;
                        color: #333;
                    }
                </style>
            </head>

            <body>
                <div class="container">
                    <jsp:include page="/WEB-INF/inc/sidebar.jsp" />

                    <main class="main">
                        <jsp:include page="/WEB-INF/inc/nav.jsp" />

                        <section class="content">
                            <div class="mypage-container">

                                <h2 class="mypage-title">마이페이지</h2>

                                <!-- ✅ 프로필 이미지 -->
                                <c:choose>
                                    <c:when test="${empty sessionScope.loginUser.profileImg}">
                                        <img src="<c:url value='/assets/img/non.png'/>" id="myImage"
                                            class="profile-img">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="<c:url value='${sessionScope.loginUser.profileImg}'/>" id="myImage"
                                            class="profile-img">
                                    </c:otherwise>
                                </c:choose>
                                <form id="profileForm" enctype="multipart/form-data">
                                    <input type="file" id="uploadImage" name="uploadImage" style="display:none;">
                                </form>

                                <!-- ✅ 회원정보 수정 폼 -->
                                <form id="mypageForm" method="post" action="<c:url value='/mypage/update'/>">

                                    <div class="form-group">
                                        <label for="memId">아이디</label>
                                        <input value="${sessionScope.loginUser.memId}" id="memId" name="memId"
                                            type="text" readonly />
                                    </div>

                                    <div class="form-group">
                                        <label for="memName">이름</label>
                                        <input value="${sessionScope.loginUser.memName}" id="memName" name="memName"
                                            type="text" readonly />
                                    </div>

                                    <div class="form-group">
                                        <label for="memMail">이메일</label>
                                        <input value="${sessionScope.loginUser.memMail}" id="memMail" name="memMail"
                                            type="email" readonly />
                                    </div>

                                    <div class="form-group">
                                        <label for="memHp">휴대폰 번호</label>
                                        <input value="${sessionScope.loginUser.memHp}" id="memHp" name="memHp"
                                            type="text" readonly />
                                    </div>

                                    <div class="form-group">
                                        <label for="memBir">생년월일</label>
                                        <!-- 날짜 포맷팅 (yyyy-MM-dd) -->
                                        <fmt:formatDate value="${sessionScope.loginUser.memBir}" pattern="yyyy-MM-dd"
                                            var="birthDate" />
                                        <input value="${birthDate}" id="memBir" name="memBir" type="date" readonly />
                                    </div>

                                    <!-- 버튼 -->
                                    <div class="btn-wrap">
                                        <button type="button" id="editBtn" class="btn btn-secondary">수정</button>
                                        <button class="btn btn-primary" id="saveBtn" type="submit"
                                            disabled>저장하기</button>
                                    </div>
                                </form>
                            </div>
                        </section>
                    </main>
                </div>

                <jsp:include page="/WEB-INF/inc/footer.jsp" />

                <script>
                    $(document).ready(function () {
                        // ✅ 수정 버튼 눌렀을 때 readonly 해제 + 프로필 변경 가능
                        $("#editBtn").click(function () {
                            $("#mypageForm input").removeAttr("readonly");
                            $("#saveBtn").prop("disabled", false);
                            $(this).prop("disabled", true);

                            // 프로필 이미지도 클릭 가능하게
                            $("#myImage").css("cursor", "pointer");
                            $("#myImage").on("click", function () {
                                $("#uploadImage").click();
                            });
                        });

                        // ✅ AJAX 이미지 업로드
                        $("#uploadImage").on("change", function () {
                            var formData = new FormData($("#profileForm")[0]);
                            $.ajax({
                                url: '<c:url value="/files/upload"/>',
                                type: 'POST',
                                data: formData,
                                processData: false,
                                contentType: false,
                                success: function (res) {
                                    if (res.message === 'success') {
                                        $("#myImage").attr("src", res.imagePath);
                                        $("#topImage").attr("src", res.imagePath);
                                    } else {
                                        alert("이미지 업로드 실패");
                                    }
                                },
                                error: function (e) {
                                    console.log(e);
                                    alert("업로드 중 오류가 발생했습니다.");
                                }
                            });
                        });
                    });
                </script>
            </body>

            </html>