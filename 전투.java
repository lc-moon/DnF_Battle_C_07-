package game;

public class 전투 {
    
    public 캐릭터 캐릭터생성(String 플레이어id, String 캐릭터명, String 직업, int 레벨) {
        플레이어 player = new 플레이어();
        
        // Include: 플레이어체크 수행
        if (player.플레이어체크(플레이어id)) {
            if ("전사".equals(직업)) {
                return new 전사(캐릭터명, 레벨);
            } else if ("마법사".equals(직업)) {
                return new 마법사(캐릭터명, 레벨);
            }
        }
        return null; // 인증 실패 시 null 반환
    }

    public String 몬스터공격(String 플레이어id, 캐릭터 캐릭터객체) {
        플레이어 player = new 플레이어();
        
        // Include: 플레이어체크 수행
        if (!player.플레이어체크(플레이어id)) {
            return "인증되지 않은 플레이어입니다.";
        }

        if (캐릭터객체 == null) {
            return "오류: 생성된 캐릭터가 없습니다.";
        }

        // 스킬발동 및 데미지 파싱
        String 스킬결과 = 캐릭터객체.스킬발동();
        String[] parts = 스킬결과.split("\\|");
        String 스킬명 = parts[0];
        double 데미지 = Double.parseDouble(parts[1]);

        // 데미지에 따른 등급 부여
        String 등급 = "";
        if (데미지 >= 200) {
            등급 = "S급";
        } else if (데미지 >= 100) {
            등급 = "A급";
        } else {
            등급 = "B급";
        }

        return String.format("스킬: %s <br>데미지: %.1f <br>결과: %s 공격", 스킬명, 데미지, 등급);
    }
}