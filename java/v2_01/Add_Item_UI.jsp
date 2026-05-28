<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="게임.캐릭터" %>
<%@ page import="게임.아이템" %>
<jsp:useBean id="전투시스템" class="게임.전투" scope="application" />
<%
    request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>[DnF_C07] 아이템 획득 UI</title>
</head>
<body>
    <h2>[DnF_Battle_C_07팀] 아이템 획득 시스템</h2>

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
                <strong>현재 캐릭터 인벤토리 상태:</strong> <br>
                캐릭터명: <%= 세션캐릭터.get캐릭터명() %> <br>
                아이템 보유량: <strong><%= 세션캐릭터.get인벤토리멤버().get아이템리스트크기() %></strong> / <%= 세션캐릭터.get인벤토리멤버().get최대용량() %>개
            </div>
            <br><br>
     
            <form action="Add_Item_UI.jsp" method="post">
                <input type="hidden" name="action" value="addItem">
                <table border="1" cellpadding="5">
                    <tr>
                        <td>플레이어 ID 검증:</td>
                        <td><input type="text" name="playerId" value="hero" required></td>
                    </tr>
                    <tr>
                        <td>아이템명:</td>
                        <td><input type="text" name="itemName" placeholder="예: 무형검 아르게스" required></td>
                    </tr>
                    <tr>
                        <td>아이템 타입:</td>
                        <td>
                            <select name="itemType">
                                <option value="무기">무기</option>
                                <option value="방어구">방어구</option>
                                <option value="물약">물약</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>아이템 가치(수치):</td>
                        <td><input type="number" name="itemValue" value="100" min="1" required> (전설:1000이상, 희귀:500이상)</td>
                    </tr>
                </table>
                <br>
                <input type="submit" value="아이템획득">
            </form>
    <%
        }
    %>

    <hr>

    <%
        String action = request.getParameter("action");
        if("addItem".equals(action) && 세션캐릭터 != null) {
            String playerId = request.getParameter("playerId");
            String itemName = request.getParameter("itemName");
            String itemType = request.getParameter("itemType");
            String itemValueStr = request.getParameter("itemValue");
            
            if(playerId != null && itemName != null && itemType != null && itemValueStr != null) {
                int itemValue = Integer.parseInt(itemValueStr);
                
                // 순차 다이어그램 흐름대로 전투 클래스 메서드 호출
                String 결과메시지 = 전투시스템.아이템획득(playerId, itemName, itemType, itemValue, 세션캐릭터);
                
                if(결과메시지.contains("실패") || 결과메시지.contains("초과")) {
    %>
                    <h3 style="color: red;">❌ <%= 결과메시지 %></h3>
    <%
                } else {
    %>
                    <h3 style="color: green;">🎁 인벤토리 업데이트 성공</h3>
                    <blockquote style="background: #eef; padding: 15px; border-left: 5px solid #00f;">
                        <%= 결과메시지 %>
                    </blockquote>
                    
                    <h4>[현재 보관중인 아이템 리스트]</h4>
                    <table border="1" cellpadding="5" style="background-color: #fafafa;">
                        <tr style="background:#ddd;"><th>아이템명</th><th>타입</th><th>가치</th><th>등급</th></tr>
                        <% for(아이템 item : 세션캐릭터.get인벤토리멤버().get아이템리스트()) { %>
                            <tr>
                                <td><%= item.get아이템명() %></td>
                                <td><%= item.get타입() %></td>
                                <td><%= item.get가치() %></td>
                                <td><%= item.get등급() %></td>
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
    <a href="Join_Guild_UI.jsp">🛡️ 길드 가입 화면으로 이동</a>
</body>
</html>