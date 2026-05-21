<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="game.*" %> <%
    request.setCharacterEncoding("UTF-8");
    String method = request.getMethod();
    String resultMsg = "";
    캐릭터 생성된캐릭터 = null;

    if ("POST".equalsIgnoreCase(method)) {
        String 플레이어id = request.getParameter("플레이어id");
        String 캐릭터명 = request.getParameter("캐릭터명");
        String 직업 = request.getParameter("직업");
        int 레벨 = Integer.parseInt(request.getParameter("레벨"));

        전투 battle = new 전투();
        생성된캐릭터 = battle.캐릭터생성(플레이어id, 캐릭터명, 직업, 레벨);

        if (생성된캐릭터 != null) {
            // 공격 페이지에서 사용할 수 있도록 세션에 저장
            session.setAttribute("캐릭터객체", 생성된캐릭터);
            resultMsg = "캐릭터 생성 완료! <br>직업: " + 직업 + " / HP: " + 생성된캐릭터.getHP() + " / 공격력: " + 생성된캐릭터.get공격력();
        } else {
            resultMsg = "인증되지 않은 플레이어입니다. (id가 hero인지 확인하세요)";
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>캐릭터 생성</title>
</head>
<body>
    <h3>Create_Character_UI</h3>
    <form method="post">
        플레이어 ID: <input type="text" name="플레이어id" value="hero"><br>
        캐릭터명: <input type="text" name="캐릭터명" value="아라드인"><br>
        직업:
        <select name="직업">
            <option value="전사">전사</option>
            <option value="마법사">마법사</option>
        </select><br>
        레벨: <input type="number" name="레벨" value="10"><br>
        <button type="submit">캐릭터 생성</button>
    </form>
    
    <p><strong>처리 결과:</strong><br> <%= resultMsg %></p>
    
    <% if (생성된캐릭터 != null) { %>
        <br><a href="Attack_Monster_UI.jsp">[ 몬스터 공격 화면으로 이동 ]</a>
    <% } %>
</body>
</html>