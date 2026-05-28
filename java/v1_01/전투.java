// 전투.java
package 게임;

public class 전투 {
    private 플레이어 플레이어검증기 = new 플레이어();

    public 캐릭터 캐릭터생성(String 플레이어id, String 캐릭터명, String 직업, int 레벨) {
        // 내부 로직으로 플레이어체크 포함 수행
        if (!플레이어검증기.플레이어체크(플레이어id)) {
            return null; 
        }

        if ("전사".equals(직업)) {
            return new 전사(캐릭터명, 레벨);
        } else if ("마법사".equals(직업)) {
            return new 마법사(캐릭터명, 레벨);
        }
        return null;
    }

    public String 몬스터공격(String 플레이어id, 캐릭터 캐릭터객체) {
        // 내부 로직으로 플레이어체크 포함 수행
        if (!플레이어검증기.플레이어체크(플레이어id)) {
            return "인증 실패: 플레이어 ID가 올바르지 않습니다.";
        }
        if (캐릭터객체 == null) {
            return "공격 실패: 캐릭터가 존재하지 않습니다.";
        }

        String 스킬명 = 캐릭터객체.스킬발동();
        double 데미지 = 0;

        // 직업(인스턴스 타입)에 따른 데미지 배율 적용
        if (캐릭터객체 instanceof 전사) {
            데미지 = 캐릭터객체.get공격력() * 1.5;
        } else if (캐릭터객체 instanceof 마법사) {
            데미지 = 캐릭터객체.get공격력() * 2.0;
        }

        // 데미지에 따른 등급 부여 로직
        String 등급 = "";
        if (데미지 >= 200) {
            등급 = "S급 공격";
        } else if (데미지 >= 100) {
            등급 = "A급 공격";
        } else {
            등급 = "B급 공격";
        }

        return "스킬: [" + 스킬명 + "] | 데미지: " + 데미지 + " | 판정: " + 등급;
    }
}