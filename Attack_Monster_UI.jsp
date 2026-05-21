<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="game.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    String method = request.getMethod();
    String resultMsg = "";

    if ("POST".equalsIgnoreCase(method)) {
        String 플레이어id = request.getParameter("플레이어id");
        // 세션에서 캐릭터 객체 불러오기
        캐릭터 캐릭터객체 = (캐릭터) session.getAttribute("캐릭터객체");

        전투 battle = new 전투();
        resultMsg = battle.몬스터공격(플레이어id, 캐릭터객체);
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>몬스터 공격</title>
</head>
<body>
    <h3>Attack_Monster_UI</h3>
    <% if (session.getAttribute("캐릭터객체") == null) { %>
        <p>생성된 캐릭터가 없습니다.</p>
        <a href="Create_Character_UI.jsp">[ 캐릭터 생성으로 돌아가기 ]</a>
    <% } else { %>
        <form method="post">
            플레이어 ID 확인: <input type="text" name="플레이어id" value="hero">
            <button type="submit">몬스터 공격!</button>
        </form>
        
        <p><strong>전투 결과:</strong><br> <%= resultMsg %></p>
        <br><a href="Create_Character_UI.jsp">[ 다시 캐릭터 생성하기 ]</a>
    <% } %>
</body>
</html>