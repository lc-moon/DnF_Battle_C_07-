```mermaid
sequenceDiagram
    autonumber
    actor Player as 플레이어 (사용자)
    participant UI as Add_Item_UI
    participant B as 전투
    participant P as 플레이어
    participant C as 캐릭터
    participant I as 인벤토리
    participant IT as 아이템

    Player->>UI: 아이템 획득 요청(플레이어id, 아이템명, 타입, 가치, 캐릭터객체)
    activate UI
    
    UI->>B: 아이템획득(플레이어id, 아이템명, 타입, 가치, 캐릭터객체)
    activate B
    
    %% 플레이어체크 선행 필수 (Include)
    B->>P: 플레이어체크(플레이어id)
    activate P
    P-->>B: 체크 결과 반환 (true / false)
    deactivate P

    alt 플레이어체크 성공 (true)
        %% 캐릭터를 통해 컴포지션 관계인 인벤토리 확인
        B->>C: get인벤토리멤버()
        activate C
        C-->>B: 인벤토리 객체 반환
        deactivate C
        
        %% 인벤토리의 현재 수량 및 최대 용량 검증
        B->>I: get아이템리스트크기()
        activate I
        I-->>B: 현재 아이템 개수 반환
        deactivate I
        
        alt 현재 아이템 개수 < 10 (인벤토리 여유 있음)
            %% 아이템 가치에 따른 등급 부여 자체 연산
            Note over B: [등급 부여 로직]<br>- 가치 1000 이상: 전설(Legendary)<br>- 가치 500 이상: 희귀(Rare)<br>- 가치 500 미만: 일반(Common)
            
            %% 생성 및 추가
            B->>IT: 아이템 객체 생성(아이템명, 타입, 가치, 결정된 등급)
            activate IT
            IT-->>B: 생성된 아이템 객체 반환
            deactivate IT
            
            B->>I: 아이템추가(아이템객체)
            activate I
            I-->>B: 추가 완료 결과 반환 (true)
            deactivate I
            
            B-->>UI: 아이템 획득 성공 메시지 반환 (획득 아이템 정보 및 등급)
        else 현재 아이템 개수 >= 10 (인벤토리 가득 참)
            B-->>UI: "인벤토리가 가득 차서 아이템을 획득할 수 없습니다." 반환
        end
        
    else 플레이어체크 실패 (false)
        B-->>UI: "인증 실패" 에러 메시지 반환
    end
    deactivate B

    UI-->>Player: 아이템 획득 결과 화면 출력 (성공 로그 또는 에러 메시지)
    deactivate UIsequenceDiagram
    autonumber
    actor Player as 플레이어 (사용자)
    participant UI as Add_Item_UI
    participant B as 전투
    participant P as 플레이어
    participant C as 캐릭터
    participant I as 인벤토리
    participant IT as 아이템

    Player->>UI: 아이템 획득 요청(플레이어id, 아이템명, 타입, 가치, 캐릭터객체)
    activate UI
    
    UI->>B: 아이템획득(플레이어id, 아이템명, 타입, 가치, 캐릭터객체)
    activate B
    
    %% 플레이어체크 선행 필수 (Include)
    B->>P: 플레이어체크(플레이어id)
    activate P
    P-->>B: 체크 결과 반환 (true / false)
    deactivate P

    alt 플레이어체크 성공 (true)
        %% 캐릭터를 통해 컴포지션 관계인 인벤토리 확인
        B->>C: get인벤토리멤버()
        activate C
        C-->>B: 인벤토리 객체 반환
        deactivate C
        
        %% 인벤토리의 현재 수량 및 최대 용량 검증
        B->>I: get아이템리스트크기()
        activate I
        I-->>B: 현재 아이템 개수 반환
        deactivate I
        
        alt 현재 아이템 개수 < 10 (인벤토리 여유 있음)
            %% 아이템 가치에 따른 등급 부여 자체 연산
            Note over B: [등급 부여 로직]<br>- 가치 1000 이상: 전설(Legendary)<br>- 가치 500 이상: 희귀(Rare)<br>- 가치 500 미만: 일반(Common)
            
            %% 생성 및 추가
            B->>IT: 아이템 객체 생성(아이템명, 타입, 가치, 결정된 등급)
            activate IT
            IT-->>B: 생성된 아이템 객체 반환
            deactivate IT
            
            B->>I: 아이템추가(아이템객체)
            activate I
            I-->>B: 추가 완료 결과 반환 (true)
            deactivate I
            
            B-->>UI: 아이템 획득 성공 메시지 반환 (획득 아이템 정보 및 등급)
        else 현재 아이템 개수 >= 10 (인벤토리 가득 참)
            B-->>UI: "인벤토리가 가득 차서 아이템을 획득할 수 없습니다." 반환
        end
        
    else 플레이어체크 실패 (false)
        B-->>UI: "인증 실패" 에러 메시지 반환
    end
    deactivate B

    UI-->>Player: 아이템 획득 결과 화면 출력 (성공 로그 또는 에러 메시지)
    deactivate UI