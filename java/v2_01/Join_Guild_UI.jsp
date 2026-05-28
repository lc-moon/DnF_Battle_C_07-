<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="게임.캐릭터" %>
<%@ page import="게임.길드" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<jsp:useBean id="전투시스템" class="게임.전투" scope="application" />
<%
    request.setCharacterEncoding("UTF-8");

    // 요구사항: 길드는 이미 외부 메모리 공간에 미리 생성되어 존재하는 객체여야 함.
    // 서버 전역 스코프(Application)에 테스트용 영속 길드 저장소 시뮬레이션 구현
    Map<String, 길드> 서버길드목록 = (Map<String, 길드>) application.getAttribute("serverGuilds");
    if(서버길드목록 == null) {
        서버길드목록 = new HashMap<>();
        서버길드목록.put("레인저스", new 길드("레인저스"));
        서버길드목록.put("아라드수호대", new 길드("아라드수호대"));
        application.setAttribute("serverGuilds", 서버길드목록);
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
            <a href="Create_Character_UI.jsp"><button type="button">캐릭터 생성하러 가기</button></a>
    <%
        } else {
    %>
            <div style="background-color: #f9f9f9; padding: 10px; display: inline-block; border: 1px solid #ccc;">
                <strong>가입 요청 진행 캐릭터 정보:</strong> <%= 세션캐릭터.get캐릭터명() %> (Lv.<%= 세션캐릭터.get레벨() %>)
            </div>
            <br><br>
     
            <form action="Join_Guild_UI.jsp" method="post">
                <input type="hidden" name="action" value="joinGuild">
                <table border="1" cellpadding="5">
                    <tr>
                        <td>플레이어 ID 검증:</td>
                        <td><input type="text" name="playerId" value="hero" required></td>
                    </tr>
                    <tr>
                        <td>가입 희망 길드 선택:</td>
                        <td>
                            <select name="guildName">
                                <% for(String gName : 서버길드목록.keySet()) { 
                                    길드 g = 서버길드목록.get(gName);
                                %>
                                    <option value="<%= gName %>"><%= gName %> (현재 인원: <%= g.get캐릭터리스트크기() %> / <%= g.get최대인원() %>명)</option>
                                <% } %>
                            </select>
                        </td>
                    </tr>
                </table>
                <br>
                <input type="submit" value="길드가입">
            </form>
    <%
        }
    %>

    <hr>

    <%
        String action = request.getParameter("action");
        if("joinGuild".equals(action) && 세션캐릭터 != null) {
            String playerId = request.getParameter("playerId");
            String guildName = request.getParameter("guildName");
            
            if(playerId != null && guildName != null) {
                // 이미 타인/시스템에 의해 영속화되어 존재하는 길드 객체를 주입받음
                길드 선택된길드객체 = 서버길드목록.get(guildName);
                
                // 순차 다이어그램 흐름대로 전투 클래스 메서드 호출
                String 결과메시지 = 전투시스템.길드가입(playerId, guildName, 세션캐릭터, 선택된길드객체);
                
                if(결과메시지.contains("실패") || 결과메시지.contains("초과")) {
    %>
                    <h3 style="color: red;">❌ <%= 결과메시지 %></h3>
    <%
                } else {
    %>
                    <h3 style="color: blue;">🏰 길드 가입 신청 승인</h3>
                    <p style="font-weight: bold; color: green;"><%= 결과메시지 %></p>
                    
                    <h4>[<%= guildName %> 길드 실시간 소속 인원 명단]</h4>
                    <table border="1" cellpadding="5">
                        <tr style="background-color: #eee;"><th>캐릭터명</th><th>레벨</th><th>클래스 정보</th></tr>
                        <% for(캐릭터 member : 선택된길드객체.get캐릭터리스트()) { %>
                            <tr>
                                <td><%= member.get캐릭터명() %></td>
                                <td><%= member.get레벨() %></td>
                                <td><%= member.getClass().getSimpleName() %></td>
                            </tr>
                        <% } %>
                    </table>
    <%
                }
            }
        }
    %>
    <br>
    <a href="Attack_Monster_UI.jsp">⚔️ 몬스터 공격 화면으로 이동</a> | 
    <a href="Add_Item_UI.jsp">🎁 아이템 획득 화면으로 이동</a>
</body>
</html>