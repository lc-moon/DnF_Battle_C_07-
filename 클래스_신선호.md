```mermaid
classDiagram
    class Create_Character_UI {
        <<boundary>>
    }

    class Attack_Monster_UI {
        <<boundary>>
    }

    class Add_Item_UI {
        <<boundary>>
    }

    class Join_Guild_UI {
        <<boundary>>
    }

    class 플레이어 {
        +플레이어체크(id: String) boolean
    }

    class 캐릭터 {
        <<abstract>>
        #캐릭터명: String
        #레벨: int
        #HP: int
        #공격력: int
        -인벤토리멤버: 인벤토리
        +스킬발동()* String
    }

    class 전사 {
        +스킬발동() String
    }

    class 마법사 {
        +스킬발동() String
    }

    class 인벤토리 {
        -아이템리스트: List~아이템~
        -최대용량: int
        +아이템추가(아이템객체: 아이템) boolean
    }

    class 아이템 {
        -아이템명: String
        -타입: String
        -가치: int
        -등급: String
    }

    class 길드 {
        -길드명: String
        -캐릭터리스트: List~캐릭터~
        -최대인원: int
        +캐릭터가입(캐릭터객체: 캐릭터) boolean
    }

    class 전투 {
        +캐릭터생성(플레이어id: String, 캐릭터명: String, 직업: String, 레벨: int) 캐릭터
        +몬스터공격(플레이어id: String, 캐릭터객체: 캐릭터) String
        +아이템획득(플레이어id: String, 아이템명: String, 타입: String, 가치: int, 캐릭터객체: 캐릭터) String
        +길드가입(플레이어id: String, 길드명: String, 캐릭터객체: 캐릭터, 길드객체: 길드) String
    }

    %% 관계 설정 (Relationships)
    %% 1. 상속 관계
    캐릭터 <|-- 전사 : 상속
    캐릭터 <|-- 마법사 : 상속

    %% 2. 복합객체 관계 (다중도 표기 문법 수정 및 라벨 간소화)
    캐릭터 "1" *-- "1" 인벤토리 : 캐릭터_인벤토리_합성
    인벤토리 "1" *-- "*" 아이템 : 인벤토리_아이템_1대N_합성
    길드 "1" o-- "*" 캐릭터 : 길드_캐릭터_1대N_집단화

    %% 3. 바운더리 및 제어 클래스 의존 관계
    Create_Character_UI ..> 전투 : 캐릭터생성 요청
    Attack_Monster_UI ..> 전투 : 몬스터공격 요청
    Add_Item_UI ..> 전투 : 아이템획득 요청
    Join_Guild_UI ..> 전투 : 길드가입 요청

    전투 ..> 플레이어 : 플레이어체크 검증 요청
    전투 --> 캐릭터 : 생성 및 명령