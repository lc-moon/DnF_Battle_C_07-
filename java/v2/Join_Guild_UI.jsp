<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="게임.캐릭터" %>
<%@ page import="게임.길드" %>
<jsp:useBean id="전투시스템" class="게임.전투" scope="application" />
<%
    request.setCharacterEncoding("UTF-8");

    // 전역 정원 테스트를 위해 길드가 없으면 하나 생성하여 애플리케이션에 저장합니다.
    길드 가상의길드 = (길드) application.getAttribute("globalGuild");
    if(가상의길드 == null) {
        가상의길드 = new 길드("아라드모험가조합");
        application.setAttribute("globalGuild", 가상의길드);
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>[DnF_C07] 길드 가입 UI</title>
</head>
<body>
    <h2>[DnF_Battle_C_07팀] 길드 가입 시스템</h2>

    <%
        캐릭터 세션캐릭터 = (캐릭터) session.getAttribute("myChar");
        
        if(세션캐릭터 == null) {
    %>
            <p style="color: red; font-weight: bold;">⚠️ 현재 생성된 캐릭터가 존재하지 않습니다.</p>
            <p>캐릭터 생성 단계를 먼저 진행해 주세요.</p>
            <a href="Create_Character_UI.jsp"><button type="button">캐릭터 생성하러 가기</button></a>
    <%
        } else {
    %>
            <div style="background-color: #f0f0f0; padding: 10px; display: inline-block; border: 1px solid #ccc;">
                <strong>현재 접속 캐릭터 정보:</strong> 
                [<%= 세션캐릭터.getClass().getSimpleName() %>] <%= 세션캐릭터.get캐릭터명() %>
            </div>
            <br><br>
            
            <div style="border: 1px dashed green; padding: 10px; width: 350px; background-color: #fafffa;">
                <strong>가입 대상 길드 정보:</strong><br>
                • 길드명: <%= 가상의길드.get길드명() %><br>
                • 현재 길드원 수: <%= 가상의길드.get캐릭터리스트크기() %> / 5 명
            </div>
            <br>
     
            <form action="Join_Guild_UI.jsp" method="post">
                <input type="hidden" name="action" value="joinGuild">
                <table border="1" cellpadding="5">
                    <tr>
                        <td>플레이어 ID 검증:</td>
                        <td><input type="text" name="playerId" value="hero" required></td>
                    </tr>
                    <tr>
                        <td>길드 이름 확인:</td>
                        <td><input type="text" name="guildName" value="<%= 가상의길드.get길드명() %>" readonly></td>
                    </tr>
                </table>
                <br>
                <input type="submit" value="길드 가입 신청">
            </form>
    <%
        }
    %>

    <hr>

    <%
        String action = request.getParameter("action");
        if("joinGuild".equals(action) && 세션캐릭터 != null) {
            String playerId = request.getParameter("playerId");
            
            if(playerId != null) {
                // 전투 제어 클래스로 가입 비즈니스 로직 위임
                String 결과메시지 = 전투시스템.길드가입(playerId, 가상의길드.get길드명(), 세션캐릭터, 가상의길드);
                
                if("인증 실패".equals(결과메시지)) {
    %>
                    <h3 style="color: red;">❌ 인증 실패: 플레이어 ID가 올바르지 않습니다.</h3>
    <%
                } else if("길드 정원 초과".equals(결과메시지)) {
    %>
                    <h3 style="color: orange;">❌ 길드 가입 실패: 길드 정원(5명)이 초과되었습니다.</h3>
    <%
                } else if("길드 가입 성공 메시지 반환".equals(결과메시지)) {
    %>
                    <h3 style="color: blue;">🎉 축하합니다! [<%= 가상의길드.get길드명() %>] 길드 가입에 성공했습니다.</h3>
                    <%-- 새로고침 시 인원 반영 업데이트를 위해 객체 상태 재확인용 스크립트 리프레시 유도 가능 --%>
    <%
                }
            }
        }
    %>

    <h3>👥 현재 명부 내 길드원 목록</h3>
    <table border="1" cellpadding="5">
        <tr style="background-color: #e0e0e0;">
            <th>직업</th><th>캐릭터명</th><th>레벨</th>
        </tr>
        <% if(가상의길드.get캐릭터리스트().isEmpty()) { %>
            <tr><td colspan="3" style="text-align: center; color: gray;">등록된 길드원이 없습니다.</td></tr>
        <% } else { 
            for(캐릭터 member : 가상의길드.get캐릭터리스트()) {
        %>
            <tr>
                <td><%= member.getClass().getSimpleName() %></td>
                <td><%= member.get캐릭터명() %></td>
                <td>Lv.<%= member.get레벨() %></td>
            </tr>
        <% } } %>
    </table>

    <br><br>
    <a href="Add_Item_UI.jsp">◀ 아이템 획득 화면으로 돌아가기</a> | 
    <a href="Create_Character_UI.jsp">처음으로 (다른 캐릭터 만들기)</a>
</body>
</html>