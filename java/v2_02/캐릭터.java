// 캐릭터.java (추상 클래스)
package 게임;

public abstract class 캐릭터 {
    protected String 캐릭터명;
    protected int 레벨;
    protected int HP;
    protected int 공격력;
    
    // 클래스 다이어그램 명세에 따른 인벤토리멤버 추가 (-인벤토리멤버: 인벤토리)
    private 인벤토리 인벤토리멤버;

    public 캐릭터() {
        // 캐릭터가 생성될 때 인벤토리도 함께 생성됩니다.
        this.인벤토리멤버 = new 인벤토리();
    }

    public abstract String 스킬발동();

    // JSP 및 전투 클래스에서 데이터를 읽기 위한 Getter 메소드들
    public String get캐릭터명() { return 캐릭터명; }
    public int get레벨() { return 레벨; }
    public int getHP() { return HP; }
    public int get공격력() { return 공격력; }
    public 인벤토리 get인벤토리멤버() { return 인벤토리멤버; }
}