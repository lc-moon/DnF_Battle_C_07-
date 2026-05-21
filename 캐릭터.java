package game;

public abstract class 캐릭터 {
    protected String 캐릭터명;
    protected int 레벨;
    protected int HP;
    protected int 공격력;

    // 시퀀스 다이어그램에서 스킬명과 데미지를 함께 처리해야 하므로
    // 구분자를 포함한 문자열을 반환하도록 설계합니다.
    public abstract String 스킬발동();

    public String get캐릭터명() { return 캐릭터명; }
    public int get레벨() { return 레벨; }
    public int getHP() { return HP; }
    public int get공격력() { return 공격력; }
}