```mermaid

sequenceDiagram

&#x20;   autonumber

&#x20;   actor Player as 플레이어 (사용자)

&#x20;   participant UI as Add\_Item\_UI

&#x20;   participant B as 전투

&#x20;   participant P as 플레이어

&#x20;   participant C as 캐릭터

&#x20;   participant I as 인벤토리

&#x20;   participant IT as 아이템



&#x20;   Player->>UI: 아이템 획득 요청(플레이어id, 아이템명, 타입, 가치, 캐릭터객체)

&#x20;   activate UI

&#x20;   

&#x20;   UI->>B: 아이템획득(플레이어id, 아이템명, 타입, 가치, 캐릭터객체)

&#x20;   activate B

&#x20;   

&#x20;   %% 플레이어체크 선행 필수 (Include)

&#x20;   B->>P: 플레이어체크(플레이어id)

&#x20;   activate P

&#x20;   P-->>B: 체크 결과 반환 (true / false)

&#x20;   deactivate P



&#x20;   alt 플레이어체크 성공 (true)

&#x20;       %% 캐릭터를 통해 컴포지션 관계인 인벤토리 확인

&#x20;       B->>C: get인벤토리멤버()

&#x20;       activate C

&#x20;       C-->>B: 인벤토리 객체 반환

&#x20;       deactivate C

&#x20;       

&#x20;       %% 인벤토리의 현재 수량 및 최대 용량 검증

&#x20;       B->>I: get아이템리스트크기()

&#x20;       activate I

&#x20;       I-->>B: 현재 아이템 개수 반환

&#x20;       deactivate I

&#x20;       

&#x20;       alt 현재 아이템 개수 < 10 (인벤토리 여유 있음)

&#x20;           %% 아이템 가치에 따른 등급 부여 자체 연산

&#x20;           Note over B: \[등급 부여 로직]<br>- 가치 1000 이상: 전설(Legendary)<br>- 가치 500 이상: 희귀(Rare)<br>- 가치 500 미만: 일반(Common)

&#x20;           

&#x20;           %% 생성 및 추가

&#x20;           B->>IT: 아이템 객체 생성(아이템명, 타입, 가치, 결정된 등급)

&#x20;           activate IT

&#x20;           IT-->>B: 생성된 아이템 객체 반환

&#x20;           deactivate IT

&#x20;           

&#x20;           B->>I: 아이템추가(아이템객체)

&#x20;           activate I

&#x20;           I-->>B: 추가 완료 결과 반환 (true)

&#x20;           deactivate I

&#x20;           

&#x20;           B-->>UI: 아이템 획득 성공 메시지 반환 (획득 아이템 정보 및 등급)

&#x20;       else 현재 아이템 개수 >= 10 (인벤토리 가득 참)

&#x20;           B-->>UI: "인벤토리가 가득 차서 아이템을 획득할 수 없습니다." 반환

&#x20;       end

&#x20;       

&#x20;   else 플레이어체크 실패 (false)

&#x20;       B-->>UI: "인증 실패" 에러 메시지 반환

&#x20;   end

&#x20;   deactivate B



&#x20;   UI-->>Player: 아이템 획득 결과 화면 출력 (성공 로그 또는 에러 메시지)

&#x20;   deactivate UI

