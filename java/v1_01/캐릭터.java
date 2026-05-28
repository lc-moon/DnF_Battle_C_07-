// 캐릭터.java (추상 클래스)
package 게임;

public abstract class 캐릭터 {
    protected String 캐릭터명;
    protected int 레벨;
    protected int HP;
    protected int 공격력;

    public abstract String 스킬발동();

    // JSP 및 전투 클래스에서 데이터를 읽기 위한 Getter 메소드들
    public String get캐릭터명() { return 캐릭터명; }
    public int get레벨() { return 레벨; }
    public int getHP() { return HP; }
    public int get공격력() { return 공격력; }
}