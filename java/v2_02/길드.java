// 길드.java
package 게임;

import java.util.ArrayList;
import java.util.List;

public class 길드 {
    private String 길드명;
    private List<캐릭터> 캐릭터리스트;
    private int 최대인원 = 5;

    public 길드(String 길드명) {
        this.길드명 = 길드명;
        this.캐릭터리스트 = new ArrayList<>();
    }

    // 시퀀스 다이어그램 7번 항목: get캐릭터리스트크기()
    public int get캐릭터리스트크기() {
        return 캐릭터리스트.size();
    }

    // 시퀀스 다이어그램 10번 항목: 캐릭터가입(캐릭터객체)
    public boolean 캐릭터가입(캐릭터 캐릭터객체) {
        if (캐릭터리스트.size() < 최대인원) {
            캐릭터리스트.add(캐릭터객체);
            return true;
        }
        return false;
    }

    public String get길드명() {
        return 길드명;
    }

    public List<캐릭터> get캐릭터리스트() {
        return 캐릭터리스트;
    }
}