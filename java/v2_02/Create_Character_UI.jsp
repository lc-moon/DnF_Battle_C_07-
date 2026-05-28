<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="게임.캐릭터" %>
<jsp:useBean id="전투시스템" class="게임.전투" scope="application" />
<%
    request.setCharacterEncoding("UTF-8");
    캐릭터 나의캐릭터 = (캐릭터) session.getAttribute("myChar");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>[DnF_C07] 캐릭터 생성 UI</title>
</head>
<body>
    <h2>[DnF_Battle_C_07팀] 캐릭터 생성 시스템</h2>
    
    <form action="Create_Character_UI.jsp" method="post">
        <input type="hidden" name="action" value="create">
        
        <table border="1" cellpadding="5">
            <tr>
                <td>플레이어 ID:</td>
                <td><input type="text" name="playerId" value="hero" required> (ID: hero 만 가능)</td>
            </tr>
            <tr>
                <td>캐릭터명:</td>
                <td><input type="text" name="charName" placeholder="캐릭터 이름을 입력하세요" required></td>
            </tr>
            <tr>
                <td>직업:</td>
                <td>
                    <input type="radio" name="job" value="전사" checked> 전사
                    <input type="radio" name="job" value="마법사"> 마법사
                </td>
            </tr>
            <tr>
                <td>레벨:</td>
                <td><input type="number" name="level" value="1" min="1" required></td>
            </tr>
        </table>
        <br>
        <input type="submit" value="캐릭터생성">
    </form>

    <hr>

    <%
        String action = request.getParameter("action");
        if("create".equals(action)) {
            String playerId = request.getParameter("playerId");
            String charName = request.getParameter("charName");
            String job = request.getParameter("job");
            String levelStr = request.getParameter("level");
            if(playerId != null && charName != null && job != null && levelStr != null) {
                int level = Integer.parseInt(levelStr);
                
                캐릭터 생성결과 = 전투시스템.캐릭터생성(playerId, charName, job, level);
                if(생성결과 != null) {
                    session.setAttribute("myChar", 생성결과);
    %>
                    <h3 style="color: blue;">✔ 정상적으로 캐릭터가 생성되었습니다!</h3>
                    <table border="1" cellpadding="5" style="background-color: #f9f9f9;">
                        <tr><th>캐릭터명</th><td><%= 생성결과.get캐릭터명() %></td></tr>
                        <tr><th>직업</th><td><%= job %></td></tr>
                        <tr><th>레벨</th><td><%= 생성결과.get레벨() %></td></tr>
                        <tr><th>기본 HP</th><td><%= 생성결과.getHP() %></td></tr>
                        <tr><th>기본 공격력</th><td><%= 생성결과.get공격력() %></td></tr>
                    </table>
                    <br>
                    <div style="display: flex; gap: 10px;">
                        <a href="Attack_Monster_UI.jsp"><button type="button" style="padding:5px 10px; font-weight:bold; background-color: #ffeae8; cursor:pointer;">⚔️ 1단계: 몬스터 공격하러 가기 ➔</button></a>
                        <a href="Add_Item_UI.jsp"><button type="button" style="padding:5px 10px; font-weight:bold; background-color: #eaf4ff; cursor:pointer;">🎒 2단계: 아이템 획득하러 가기 ➔</button></a>
                        <a href="Join_Guild_UI.jsp"><button type="button" style="padding:5px 10px; font-weight:bold; background-color: #eaffea; cursor:pointer;">👥 3단계: 길드 가입하러 가기 ➔</button></a>
                    </div>
    <%
                } else {
    %>
                    <h3 style="color: red;">❌ [오류] 인증되지 않은 플레이어입니다. (입력된 ID: <%= playerId %>)</h3>
    <%
                }
            }
        }
    %>
</body>
</html>