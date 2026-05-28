// 길드.java
package 게임;

import java.util.ArrayList;
import java.util.List;

public class 길드 {
    private String 길드명;
    private List<캐릭터> 캐릭터리스트;
    private int 최대인원;

    public 길드(String 길드명) {
        this.길드명 = 길드명;
        this.캐릭터리스트 = new ArrayList<>();
        this.최대인원 = 5; // 요구사항: 정원은 최대 5명
    }

    // 클래스 다이어그램 스펙: +캐릭터가입(캐릭터객체: 캐릭터) boolean
    public boolean 캐릭터가입(캐릭터 캐릭터객체) {
        if (캐릭터리스트.size() >= 최대인원) {
            return false;
        }
        // 중복 가입 방지 체크
        if (캐릭터리스트.contains(캐릭터객체)) {
            return false;
        }
        return 캐릭터리스트.add(캐릭터객체);
    }

    // 순차 다이어그램 스펙: +get캐릭터리스트크기()
    public int get캐릭터리스트크기() {
        return 캐릭터리스트.size();
    }

    public String get길드명() { return 길드명; }
    public List<캐릭터> get캐릭터리스트() { return 캐릭터리스트; }
    public int get최대인원() { return 최대인원; }
}