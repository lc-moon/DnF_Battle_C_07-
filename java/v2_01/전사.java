// 전사.java
package 게임;

public class 전사 extends 캐릭터 {
    public 전사(String 캐릭터명, int 레벨) {
        super(); // 상위 클래스의 인벤토리 초기화 생성자 호출
        this.캐릭터명 = 캐릭터명;
        this.레벨 = 레벨;
        this.HP = 레벨 * 100;
        this.공격력 = 레벨 * 15;
    }

    @Override
    public String 스킬발동() {
        return "검 휘두르기!";
    }
}