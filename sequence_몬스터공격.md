```mermaid
sequenceDiagram
    autonumber
    actor Player as 플레이어 (사용자)
    participant UI as Attack_Monster_UI
    participant B as 전투
    participant P as 플레이어
    participant W as 전사
    participant M as 마법사

    Player->>UI: 몬스터 공격 요청(플레이어id, 캐릭터객체)
    activate UI
    
    UI->>B: 몬스터공격(플레이어id, 캐릭터객체)
    activate B
    
    %% 전투 클래스가 내부에서 플레이어체크를 수행 (Include 관계)
    B->>P: 플레이어체크(플레이어id)
    activate P
    Note over P: 플레이어id가 "hero"인지 확인
    P-->>B: 체크 결과 반환 (true / false)
    deactivate P

    alt 플레이어체크 성공 (true)
        alt 캐릭터객체가 "전사" 인스턴스인 경우
            B->>W: 스킬발동()
            activate W
            Note over W: 데미지 = 공격력 * 1.5
            W-->>B: "검 휘두르기! (데미지 반환)"
            deactivate W
        else 캐릭터객체가 "마법사" 인스턴스인 경우
            B->>M: 스킬발동()
            activate M
            Note over M: 데미지 = 공격력 * 2.0
            M-->>B: "파이어볼! (데미지 반환)"
            deactivate M
        end
        
        Note over B: [등급 부여 로직]<br>- 데미지 200 이상: S급<br>- 데미지 100 이상: A급<br>- 데미지 100 미만: B급
        
        B-->>UI: 전투 결과 메시지 반환 (스킬명, 데미지, 등급)
        
    else 플레이어체크 실패 (false)
        B-->>UI: "인증 실패" 에러 메시지 반환
    end
    deactivate B

    UI-->>Player: 공격 결과 화면 출력 (전투 결과 또는 에러 메시지)
    deactivate UI