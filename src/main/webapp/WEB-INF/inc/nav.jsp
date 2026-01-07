<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<nav class="navbar">
    <div class="menu-right">
        <!--  로그인 안 했을 때 -->
        <c:if test="${empty loginUser}">
            <a href="<c:url value='/login'/>" class="btn login">로그인</a>
            <a href="<c:url value='/join'/>" class="btn signup">회원가입</a>
        </c:if>

        <!--  로그인 했을 때 -->
        <c:if test="${not empty loginUser}">
            <!-- 프로필 사진 먼저 -->
            <c:choose>
                <c:when test="${empty loginUser.profileImg}">
                    <!-- 기본 이미지 -->
                    <img src="<c:url value='/assets/img/non.png'/>"
                         id="topImage"
                         class="rounded-circle"
                         width="60" height="60"
                         style="object-fit:cover; margin-right:10px;">
                </c:when>
                <c:otherwise>
                    <!-- 업로드한 프로필 이미지 -->
                    <img src="<c:url value='${loginUser.profileImg}'/>"
                         id="topImage"
                         class="rounded-circle"
                         width="60" height="60"
                         style="object-fit:cover; margin-right:10px;">
                </c:otherwise>
            </c:choose>

            <!-- 환영 메시지 -->
            <span style="margin-right:10px;">
                ${loginUser.memName} 님 환영합니다!
            </span>

            <!-- 로그아웃 버튼 -->
            <a href="<c:url value='/logout'/>" class="btn">로그아웃</a>
        </c:if>
    </div>
</nav>
