<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="game.*" %> <%
    request.setCharacterEncoding("UTF-8");
    
    // 어떤 버튼을 눌렀는지 구분하기 위한 파라미터
    String action = request.getParameter("action"); 
    String resultMsg = "";
    
    전투 battle = new 전투();
    
    // 1. 캐릭터 생성 요청이 들어왔을 때
    if ("create".equals(action)) {
        String 플레이어id = request.getParameter("플레이어id");
        String 캐릭터명 = request.getParameter("캐릭터명");
        String 직업 = request.getParameter("직업");
        int 레벨 = Integer.parseInt(request.getParameter("레벨"));
        
        캐릭터 생성된캐릭터 = battle.캐릭터생성(플레이어id, 캐릭터명, 직업, 레벨);
        
        if (생성된캐릭터 != null) {
            // 생성 성공 시 세션에 저장하여 페이지가 새로고침되어도 유지되도록 함
            session.setAttribute("캐릭터객체", 생성된캐릭터);
            resultMsg = "캐릭터 생성 완료! (직업: " + 직업 + " / HP: " + 생성된캐릭터.getHP() + " / 공격력: " + 생성된캐릭터.get공격력() + ")";
        } else {
            resultMsg = "캐릭터 생성 실패: 인증되지 않은 플레이어입니다. (플레이어 ID를 확인하세요)";
        }
    } 
    // 2. 몬스터 공격 요청이 들어왔을 때
    else if ("attack".equals(action)) {
        String 플레이어id = request.getParameter("플레이어id");
        // 세션에서 기존에 생성해둔 캐릭터 객체를 가져옴
        캐릭터 캐릭터객체 = (캐릭터) session.getAttribute("캐릭터객체");
        
        resultMsg = battle.몬스터공격(플레이어id, 캐릭터객체);
    } 
    // 3. 처음부터 다시 하기 (세션 초기화)
    else if ("reset".equals(action)) {
        session.removeAttribute("캐릭터객체");
        resultMsg = "캐릭터 정보가 초기화되었습니다. 새로 생성해주세요.";
    }
    
    // 현재 세션에 캐릭터가 생성되어 있는지 확인
    캐릭터 현재캐릭터 = (캐릭터) session.getAttribute("캐릭터객체");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>던전앤파이터 전투 시스템</title>
</head>
<body>
    <h2>던전앤파이터 전투 시스템 (통합 메인)</h2>
    
    <p><strong>[시스템 처리 및 전투 결과]</strong></p>
    <p><%= resultMsg.isEmpty() ? "명령을 대기 중입니다." : resultMsg %></p>
    <hr>
    
    <% if (현재캐릭터 == null) { %>
        <h3>[캐릭터 생성 단계]</h3>
        <form method="post">
            <input type="hidden" name="action" value="create">
            
            플레이어 ID: <input type="text" name="플레이어id" value="hero"><br>
            캐릭터명: <input type="text" name="캐릭터명" value="아라드인"><br>
            직업:
            <select name="직업">
                <option value="전사">전사</option>
                <option value="마법사">마법사</option>
            </select><br>
            레벨: <input type="number" name="레벨" value="10"><br><br>
            <button type="submit">캐릭터 생성 요청</button>
        </form>
        
    <% } else { %>
        <h3>[현재 보유 캐릭터 정보]</h3>
        <p>
            캐릭터명: <%= 현재캐릭터.get캐릭터명() %><br>
            레벨: <%= 현재캐릭터.get레벨() %><br>
            HP: <%= 현재캐릭터.getHP() %><br>
            기본 공격력: <%= 현재캐릭터.get공격력() %>
        </p>
        
        <h3>[몬스터 공격 단계]</h3>
        <form method="post">
            <input type="hidden" name="action" value="attack">
            
            플레이어 ID 검증: <input type="text" name="플레이어id" value="hero"><br><br>
            <button type="submit">몬스터 공격 명령</button>
        </form>
        
        <hr>
        <form method="post">
            <input type="hidden" name="action" value="reset">
            <button type="submit" style="color: red;">캐릭터 삭제 및 처음으로 이동</button>
        </form>
    <% } %>

</body>
</html>