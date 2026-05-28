// 인벤토리.java
package 게임;

import java.util.ArrayList;
import java.util.List;

public class 인벤토리 {
    private List<아이템> 아이템리스트;
    private int 최대용량;

    public 인벤토리() {
        this.아이템리스트 = new ArrayList<>();
        this.최대용량 = 10; // 요구사항: 가득 차면 (10개) 제한
    }

    // 클래스 다이어그램 스펙: +아이템추가(아이템객체: 아이템) boolean
    public boolean 아이템추가(아이템 아이템객체) {
        if (아이템리스트.size() >= 최대용량) {
            return false;
        }
        return 아이템리스트.add(아이템객체);
    }

    // 순차 다이어그램 스펙: +get아이템리스트크기()
    public int get아이템리스트크기() {
        return 아이템리스트.size();
    }

    public List<아이템> get아이템리스트() { return 아이템리스트; }
    public int get최대용량() { return 최대용량; }
}