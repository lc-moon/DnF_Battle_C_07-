// 인벤토리.java
package 게임;

import java.util.ArrayList;
import java.util.List;

public class 인벤토리 {
    private List<아이템> 아이템리스트;
    private int 최대용량 = 10;

    public 인벤토리() {
        this.아이템리스트 = new ArrayList<>();
    }

    // 시퀀스 다이어그램 13번 항목: get아이템리스트크기()
    public int get아이템리스트크기() {
        return 아이템리스트.size();
    }

    // 시퀀스 다이어그램 16번 항목: 아이템추가(아이템객체)
    public boolean 아이템추가(아이템 아이템객체) {
        if (아이템리스트.size() < 최대용량) {
            아이템리스트.add(아이템객체);
            return true;
        }
        return false;
    }

    public List<아이템> get아이템리스트() {
        return 아이템리스트;
    }
}