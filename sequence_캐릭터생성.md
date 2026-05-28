```mermaid
sequenceDiagram
    autonumber
    actor Player as 플레이어 (사용자)
    participant UI as Create_Character_UI
    participant B as 전투
    participant P as 플레이어
    participant W as 전사
    participant M as 마법사

    Player->>UI: 캐릭터 생성 요청(플레이어id, 캐릭터명, 직업, 레벨)
    activate UI
    
    UI->>B: 캐릭터생성(플레이어id, 캐릭터명, 직업, 레벨)
    activate B
    
    %% 전투 클래스가 내부에서 플레이어체크를 수행 (Include 관계의 이동)
    B->>P: 플레이어체크(플레이어id)
    activate P
    Note over P: 플레이어id가 "hero"인지 확인
    P-->>B: 체크 결과 반환 (true / false)
    deactivate P

    alt 플레이어체크 성공 (true)
        alt 직업 == "전사"
            B->>W: 전사 객체 생성(HP=레벨*100, 공격력=레벨*15)
            activate W
            W-->>B: 생성된 전사 객체 반환
            deactivate W
        else 직업 == "마법사"
            B->>M: 마법사 객체 생성(HP=레벨*60, 공격력=레벨*25)
            activate M
            M-->>B: 생성된 마법사 객체 반환
            deactivate M
        end
        
        B-->>UI: 생성된 캐릭터 객체 반환
        
    else 플레이어체크 실패 (false)
        B-->>UI: null 반환 (또는 예외 발생)
    end
    deactivate B

    %% UI는 전투 클래스의 결과에 따라 화면 처리
    alt 캐릭터 객체가 정상 반환된 경우
        UI-->>Player: 캐릭터 생성 완료 화면 출력
    else 결과가 null인 경우 (플레이어체크 실패)
        UI-->>Player: "인증되지 않은 플레이어입니다" 에러 메시지 출력
    end
    
    deactivate UI