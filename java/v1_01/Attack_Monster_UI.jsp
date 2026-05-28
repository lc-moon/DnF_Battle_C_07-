<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="게임.캐릭터" %>
<jsp:useBean id="전투시스템" class="게임.전투" scope="application" />
<%
    // 💡 공격 폼 화면에서도 한글/영문 깨짐 방지 처리
    request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>[DnF_C07] 몬스터 공격 UI</title>
</head>
<body>
    <h2>[DnF_Battel_C_07팀] 몬스터 공격 시스템</h2>

    <%
        // 세션에 저장된 캐릭터 객체를 다형성으로 받아옵니다.
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
                (Lv.<%= 세션캐릭터.get레벨() %> | 공격력: <%= 세션캐릭터.get공격력() %>)
            </div>
            <br><br>
            
            <form action="Attack_Monster_UI.jsp" method="post">
                <input type="hidden" name="action" value="attack">
                <table border="1" cellpadding="5">
                    <tr>
                        <td>플레이어 ID 검증:</td>
                        <td><input type="text" name="playerId" value="hero" required></td>
                    </tr>
                </table>
                <br>
                <input type="submit" value="몬스터공격">
            </form>
    <%
        }
    %>

    <hr>

    <%
        // 폼 서브밋 처리 (영문 파라미터 검증)
        String action = request.getParameter("action");
        if("attack".equals(action) && 세션캐릭터 != null) {
            String playerId = request.getParameter("playerId");

            if(playerId != null) {
                // 전투 클래스로 공격 처리를 위임하고 최종 메시지를 받아옴
                String 결과메시지 = 전투시스템.몬스터공격(playerId, 세션캐릭터);
                
                if(결과메시지.startsWith("인증 실패")) {
    %>
                    <h3 style="color: red;">❌ <%= 결과메시지 %></h3>
    <%
                } else {
    %>
                    <h3>⚔️ [전투 로그 결과 출력]</h3>
                    <blockquote style="background: #222; color: #fff; padding: 15px; border-left: 5px solid #ff4500; font-family: monospace; font-size: 1.1em;">
                        <%= 결과메시지 %>
                    </blockquote>
    <%
                }
            }
        }
    %>
    <br>
    <a href="Create_Character_UI.jsp">◀ 처음 화면으로 돌아가기 (새 캐릭터 생성)</a>
</body>
</html>