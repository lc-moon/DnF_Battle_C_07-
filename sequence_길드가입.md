```mermaid
sequenceDiagram
    autonumber
    actor Player as 플레이어 (사용자)
    participant UI as Join_Guild_UI
    participant B as 전투
    participant P as 플레이어
    participant G as 길드

    Player->>UI: 길드 가입 요청(플레이어id, 길드명, 캐릭터객체, 길드객체)
    activate UI
    
    UI->>B: 길드가입(플레이어id, 길드명, 캐릭터객체, 길드객체)
    activate B
    
    B->>P: 플레이어체크(플레이어id)
    activate P
    P-->>B: 체크 결과 반환 (true / false)
    deactivate P

    alt 플레이어체크 성공 (true)
        B->>G: get캐릭터리스트크기()
        activate G
        G-->>B: 현재 길드원 수 반환
        deactivate G
        
        alt 현재 길드원 수 < 5
            B->>G: 캐릭터가입(캐릭터객체)
            activate G
            Note over G: 캐릭터리스트에 추가
            G-->>B: 가입 승인 반환 (true)
            deactivate G
            
            B-->>UI: 길드 가입 성공 메시지 반환
        else 현재 길드원 수 >= 5
            B-->>UI: "길드 정원 초과" 반환
        end
        
    else 플레이어체크 실패 (false)
        B-->>UI: "인증 실패" 에러 메시지 반환
    end
    deactivate B

    UI-->>Player: 길드 가입 결과 화면 출력
    deactivate UI