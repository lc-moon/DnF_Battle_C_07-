```mermaid
graph TD
    Actor((플레이어))
    
    subgraph 던전앤파이터 전투 시스템
        UC1[캐릭터생성]
        UC2[몬스터공격]
        UC3[플레이어체크]
    end
    
    Actor --> UC1
    Actor --> UC2
    
    UC1 -.->|"&lt;&lt;include&gt;&gt;"| UC3
    UC2 -.->|"&lt;&lt;include&gt;&gt;"| UC3
    
    style Actor fill:#fff,stroke:#333,stroke-width:2px
    style UC1 fill:#fff3cd,stroke:#ffc107,stroke-width:2px
    style UC2 fill:#d4edda,stroke:#28a745,stroke-width:2px
    style UC3 fill:#f8d7da,stroke:#dc3545,stroke-width:2px