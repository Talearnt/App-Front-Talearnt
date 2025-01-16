import '../data/model/respone/keyword_category.dart';
import '../data/model/respone/keyword_talent.dart';

class GlobalValueConstants {
  static List<KeywordCategory> keywordCategoris = [
    KeywordCategory(
      code: 1000,
      name: "IT/프로그래밍",
      talentKeywords: [
        KeywordTalent(code: 1001, name: "React"),
        KeywordTalent(code: 1002, name: "HTML"),
        KeywordTalent(code: 1003, name: "CSS"),
        KeywordTalent(code: 1004, name: "JavaScript"),
        KeywordTalent(code: 1005, name: "TypeScript"),
        KeywordTalent(code: 1006, name: "Sass"),
        KeywordTalent(code: 1007, name: "Dart"),
        KeywordTalent(code: 1008, name: "JSON"),
        KeywordTalent(code: 1009, name: "Swift"),
        KeywordTalent(code: 1010, name: "Python"),
        KeywordTalent(code: 1011, name: "Java"),
        KeywordTalent(code: 1012, name: "PHP"),
        KeywordTalent(code: 1013, name: "Ruby"),
        KeywordTalent(code: 1014, name: "C#"),
        KeywordTalent(code: 1015, name: "Rust"),
        KeywordTalent(code: 1016, name: "Perl"),
        KeywordTalent(code: 1017, name: "Kotlin"),
        KeywordTalent(code: 1018, name: "R"),
        KeywordTalent(code: 1019, name: "SQL"),
        KeywordTalent(code: 1020, name: "Julia"),
        KeywordTalent(code: 1021, name: "Sass"),
        KeywordTalent(code: 1022, name: "MATLAB"),
        KeywordTalent(code: 1023, name: "Scala"),
        KeywordTalent(code: 1024, name: "C++"),
        KeywordTalent(code: 1025, name: "Rust"),
        KeywordTalent(code: 1026, name: "Go"),
        KeywordTalent(code: 1027, name: "컴퓨터 언어"),
        KeywordTalent(code: 1028, name: "AI 툴 활용"),
        KeywordTalent(code: 1029, name: "프롬프트 엔지니어링"),
        KeywordTalent(code: 1999, name: "그 외 IT/프로그래밍 관련"),
      ],
    ),
    KeywordCategory(
      code: 2000,
      name: "디자인",
      talentKeywords: [
        KeywordTalent(code: 2001, name: "로고 디자인"),
        KeywordTalent(code: 2002, name: "UX/UI 디자인"),
        KeywordTalent(code: 2003, name: "패키지 디자인"),
        KeywordTalent(code: 2004, name: "브랜드 디자인"),
        KeywordTalent(code: 2005, name: "웹 디자인"),
        KeywordTalent(code: 2006, name: "일러스트 디자인"),
        KeywordTalent(code: 2007, name: "애니메이션"),
        KeywordTalent(code: 2999, name: "그 외 디자인관련"),
      ],
    ),
    KeywordCategory(
      code: 3000,
      name: "상담",
      talentKeywords: [
        KeywordTalent(code: 3001, name: "취업 상담"),
        KeywordTalent(code: 3002, name: "고민 상담"),
        KeywordTalent(code: 3003, name: "연애 상담"),
        KeywordTalent(code: 3004, name: "진로 상담"),
        KeywordTalent(code: 3999, name: "그 외 상담관련"),
      ],
    ),
    KeywordCategory(
      code: 4000,
      name: "언어(회화)",
      talentKeywords: [
        KeywordTalent(code: 4001, name: "영어 회화"),
        KeywordTalent(code: 4002, name: "일본어 회화"),
        KeywordTalent(code: 4003, name: "중국어 회화"),
        KeywordTalent(code: 4004, name: "스페인어 회화"),
        KeywordTalent(code: 4005, name: "프랑스어 회화"),
        KeywordTalent(code: 4006, name: "독일어 회화"),
        KeywordTalent(code: 4007, name: "태국어 회화"),
        KeywordTalent(code: 4008, name: "이탈리아어 회화"),
        KeywordTalent(code: 4999, name: "그 외 회화관련"),
      ],
    ),
    KeywordCategory(
      code: 5000,
      name: "운동",
      talentKeywords: [
        KeywordTalent(code: 5001, name: "헬스PT/식단"),
        KeywordTalent(code: 5002, name: "요가"),
        KeywordTalent(code: 5003, name: "필라테스"),
        KeywordTalent(code: 5004, name: "수영"),
        KeywordTalent(code: 5005, name: "테니스"),
        KeywordTalent(code: 5006, name: "골프"),
        KeywordTalent(code: 5007, name: "축구"),
        KeywordTalent(code: 5008, name: "배드민턴"),
        KeywordTalent(code: 5009, name: "볼링"),
        KeywordTalent(code: 5999, name: "그 외 운동관련"),
      ],
    ),
    KeywordCategory(
      code: 6000,
      name: "사진/영상",
      talentKeywords: [
        KeywordTalent(code: 6001, name: "사진 촬영"),
        KeywordTalent(code: 6002, name: "영상 편집"),
        KeywordTalent(code: 6003, name: "드론 촬영"),
        KeywordTalent(code: 6004, name: "제품 사진"),
        KeywordTalent(code: 6005, name: "인물 사진"),
        KeywordTalent(code: 6006, name: "풍경 사진"),
        KeywordTalent(code: 6007, name: "유튜브 제작"),
        KeywordTalent(code: 6999, name: "그 외 사진/영상관련"),
      ],
    ),
    KeywordCategory(
      code: 7000,
      name: "패션/뷰티",
      talentKeywords: [
        KeywordTalent(code: 7001, name: "메이크업"),
        KeywordTalent(code: 7002, name: "헤어 스타일링"),
        KeywordTalent(code: 7003, name: "패션 스타일링"),
        KeywordTalent(code: 7004, name: "스킨케어"),
        KeywordTalent(code: 7005, name: "네일 아트"),
        KeywordTalent(code: 7006, name: "퍼스널 컬러 분석"),
        KeywordTalent(code: 7007, name: "의상 코디"),
        KeywordTalent(code: 7008, name: "바디 스타일링"),
        KeywordTalent(code: 7999, name: "그 외 패션/뷰티관련"),
      ],
    ),
    KeywordCategory(
      code: 8000,
      name: "마케팅 직무",
      talentKeywords: [
        KeywordTalent(code: 8001, name: "디지털 마케팅"),
        KeywordTalent(code: 8002, name: "콘텐츠 마케팅"),
        KeywordTalent(code: 8003, name: "퍼포먼스 마케팅"),
        KeywordTalent(code: 8004, name: "브랜드 마케팅"),
        KeywordTalent(code: 8005, name: "마케팅 전략"),
        KeywordTalent(code: 8006, name: "SNS 마케팅"),
        KeywordTalent(code: 8007, name: "광고 기획"),
        KeywordTalent(code: 8008, name: "이벤트 기획"),
        KeywordTalent(code: 8009, name: "시장 조사"),
        KeywordTalent(code: 8999, name: "그 외 마케팅 직무관련"),
      ],
    ),
    KeywordCategory(
      code: 9000,
      name: "요리",
      talentKeywords: [
        KeywordTalent(code: 9001, name: "한식 조리"),
        KeywordTalent(code: 9002, name: "양식 조리"),
        KeywordTalent(code: 9003, name: "중식 조리"),
        KeywordTalent(code: 9004, name: "일식 조리"),
        KeywordTalent(code: 9005, name: "제과제빵"),
        KeywordTalent(code: 9006, name: "푸드 스타일링"),
        KeywordTalent(code: 9999, name: "그 외 요리관련"),
      ],
    ),
    KeywordCategory(
      code: 10000,
      name: "음악",
      talentKeywords: [
        KeywordTalent(code: 10001, name: "기타 연주"),
        KeywordTalent(code: 10002, name: "피아노 연주"),
        KeywordTalent(code: 10003, name: "바이올린 연주"),
        KeywordTalent(code: 10004, name: "드럼 연주"),
        KeywordTalent(code: 10005, name: "보컬 트레이닝"),
        KeywordTalent(code: 10006, name: "작곡/편곡"),
        KeywordTalent(code: 10007, name: "음향 믹싱"),
        KeywordTalent(code: 10008, name: "음악 프로듀싱"),
        KeywordTalent(code: 10009, name: "재즈 연주"),
        KeywordTalent(code: 10999, name: "그 외 음악관련"),
      ],
    ),
    KeywordCategory(
      code: 11000,
      name: "예술",
      talentKeywords: [
        KeywordTalent(code: 11001, name: "드로잉"),
        KeywordTalent(code: 11002, name: "조각"),
        KeywordTalent(code: 11003, name: "도예"),
        KeywordTalent(code: 11004, name: "캘리그라피"),
        KeywordTalent(code: 11005, name: "디지털 아트"),
        KeywordTalent(code: 11999, name: "그 외 예술관련"),
      ],
    ),
    KeywordCategory(
      code: 12000,
      name: "재테크",
      talentKeywords: [
        KeywordTalent(code: 12001, name: "주식 투자"),
        KeywordTalent(code: 12002, name: "부동산 투자"),
        KeywordTalent(code: 12003, name: "연금 관리"),
        KeywordTalent(code: 12004, name: "가상화폐"),
        KeywordTalent(code: 12005, name: "세금 관리"),
        KeywordTalent(code: 12006, name: "채권 투자"),
        KeywordTalent(code: 12007, name: "포트폴리오 관리"),
        KeywordTalent(code: 12999, name: "그 외 재테크관련"),
      ],
    ),
    KeywordCategory(
      code: 13000,
      name: "육아",
      talentKeywords: [
        KeywordTalent(code: 13001, name: "영유아 발달"),
        KeywordTalent(code: 13002, name: "학습 지원"),
        KeywordTalent(code: 13003, name: "식습관 교육"),
        KeywordTalent(code: 13004, name: "부모 상담"),
        KeywordTalent(code: 13005, name: "심리 발달"),
        KeywordTalent(code: 13006, name: "사회성 교육"),
        KeywordTalent(code: 13999, name: "그 외 육아관련"),
      ],
    ),
    KeywordCategory(
      code: 14000,
      name: "글쓰기",
      talentKeywords: [
        KeywordTalent(code: 14001, name: "소설 쓰기"),
        KeywordTalent(code: 14002, name: "논술 작성"),
        KeywordTalent(code: 14003, name: "블로그 글쓰기"),
        KeywordTalent(code: 14004, name: "홍보 글쓰기"),
        KeywordTalent(code: 14005, name: "시나리오 작성"),
        KeywordTalent(code: 14999, name: "그 외 글쓰기 관련"),
      ],
    ),
    KeywordCategory(
      code: 15000,
      name: "댄스",
      talentKeywords: [
        KeywordTalent(code: 15001, name: "방송댄스"),
        KeywordTalent(code: 15002, name: "힙합/스트릿댄스"),
        KeywordTalent(code: 15003, name: "발레/체조/폴댄스"),
        KeywordTalent(code: 15999, name: "그 외 댄스 관련"),
      ],
    ),
  ];
}
