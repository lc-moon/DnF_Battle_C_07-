<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="게임.캐릭터" %>
<%@ page import="게임.인벤토리" %>
<%@ page import="게임.아이템" %>
<jsp:useBean id="전투시스템" class="게임.전투" scope="application" />
<%
    // 브라우저에서 넘어오는 한글 파라미터 깨짐 방지
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
        // 세션에 저장된 캐릭터 객체를 가져옴
        캐릭터 세션캐릭터 = (캐릭터) session.getAttribute("myChar");
        
        if(세션캐릭터 == null) {
    %>
            <p style="color: red; font-weight: bold;">⚠️ 현재 생성된 캐릭터가 존재하지 않습니다.</p>
            <p>캐릭터 생성 단계를 먼저 진행해 주세요.</p>
            <a href="Create_Character_UI.jsp"><button type="button">캐릭터 생성하러 가기</button></a>
    <%
        } else {
            인벤토리 인벤 = 세션캐릭터.get인벤토리멤버();
    %>
            <div style="background-color: #f0f0f0; padding: 10px; display: inline-block; border: 1px solid #ccc;">
                <strong>현재 접속 캐릭터 정보:</strong> 
                [<%= 세션캐릭터.getClass().getSimpleName() %>] <%= 세션캐릭터.get캐릭터명() %> 
                (인벤토리 현황: <%= 인벤.get아이템리스트크기() %> / 10 개)
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
                        <td><input type="text" name="itemName" placeholder="예: 단검, 마법서" required></td>
                    </tr>
                    <tr>
                        <td>타입:</td>
                        <td>
                            <select name="itemType">
                                <option value="무기">무기</option>
                                <option value="방어구">방어구</option>
                                <option value="소모품">소모품</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>가치 (골드):</td>
                        <td><input type="number" name="value" value="100" min="0" required> (1000↑ 전설 / 500↑ 희귀)</td>
                    </tr>
                </table>
                <br>
                <input type="submit" value="아이템 획득 요청">
            </form>
    <%
        }
    %>

    <hr>

    <%
        // 폼 서브밋 처리
        String action = request.getParameter("action");
        if("addItem".equals(action) && 세션캐릭터 != null) {
            String playerId = request.getParameter("playerId");
            String itemName = request.getParameter("itemName");
            String itemType = request.getParameter("itemType");
            String valueStr = request.getParameter("value");
            
            if(playerId != null && itemName != null && itemType != null && valueStr != null) {
                int value = Integer.parseInt(valueStr);
                
                // 전투 클래스로 아이템 획득 로직 위임
                String 결과메시지 = 전투시스템.아이템획득(playerId, itemName, itemType, value, 세션캐릭터);
                
                if(결과메시지.startsWith("인증 실패")) {
    %>
                    <h3 style="color: red;">❌ <%= 결과메시지 %></h3>
    <%
                } else if(결과메시지.equals("인벤토리 초과")) {
    %>
                    <h3 style="color: orange;">⚠️ 아이템을 더 이상 넣을 수 없습니다! (인벤토리 초과)</h3>
    <%
                } else {
    %>
                    <h3 style="color: blue;">✔ <%= 결과메시지 %></h3>
    <%
                }
            }
        }
    %>

    <%-- 현재 인벤토리 아이템 목록 보기 리스트 출력 (선택 사항 및 데이터 검증용) --%>
    <% if(세션캐릭터 != null) { 
        인벤토리 인벤 = 세션캐릭터.get인벤토리멤버();
    %>
        <h3>🎒 현재 인벤토리 보유 아이템 목록</h3>
        <table border="1" cellpadding="5" style="background-color: #f9f9f9;">
            <tr style="background-color: #e0e0e0;">
                <th>번호</th><th>아이템명</th><th>타입</th><th>가치</th><th>등급</th>
            </tr>
            <% if(인벤.get아이템리스트().isEmpty()) { %>
                <tr><td colspan="5" style="text-align: center; color: gray;">인벤토리가 비어 있습니다.</td></tr>
            <% } else { 
                int num = 1;
                for(게임.아이템 item : 인벤.get아이템리스트()) { 
                    String color = "black";
                    if("전설".equals(item.get등급())) color = "orange";
                    else if("희귀".equals(item.get등급())) color = "purple";
            %>
                <tr>
                    <td><%= num++ %></td>
                    <td><strong><%= item.get아이템명() %></strong></td>
                    <td><%= item.get타입() %></td>
                    <td><%= item.get가치() %> G</td>
                    <td style="color: <%= color %>; font-weight: bold;"><%= item.get등급() %></td>
                </tr>
            <% } } %>
        </table>
    <% } %>

    <br><br>
    <a href="Attack_Monster_UI.jsp">◀ 몬스터 공격 화면으로 가기</a> | 
    <a href="Join_Guild_UI.jsp">길드 가입 화면으로 이동 ➔</a>
</body>
</html>