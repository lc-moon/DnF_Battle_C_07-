package game;

public class 전사 extends 캐릭터 {
    
    public 전사(String 캐릭터명, int 레벨) {
        this.캐릭터명 = 캐릭터명;
        this.레벨 = 레벨;
        this.HP = 레벨 * 100;
        this.공격력 = 레벨 * 15;
    }

    @Override
    public String 스킬발동() {
        double 데미지 = this.공격력 * 1.5;
        // 전투 클래스에서 파싱할 수 있도록 "스킬명|데미지" 형태로 반환
        return "검 휘두르기!|" + 데미지;
    }
}