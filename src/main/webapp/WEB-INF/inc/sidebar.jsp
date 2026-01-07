<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<aside class="sidebar">
    <!-- 로고도 홈으로 이동 -->
    <div class="logo">
        <a href="<c:url value='/'/>">Maum Dairy</a>
    </div>

    <!-- 메뉴 -->
    <ul class="sidebar-menu">
        <li><a href="<c:url value='/'/>">기록</a></li>
       	<li> <a href="<c:url value='/emotion/timeline?memId=${loginUser.memId}'/>">감정 타임라인 </a></li>
        <li><a href="<c:url value='/center'/>">상담 센터</a></li>
        <li><a href="<c:url value='/mypage'/>">마이 페이지</a></li>
    </ul>
</aside>
