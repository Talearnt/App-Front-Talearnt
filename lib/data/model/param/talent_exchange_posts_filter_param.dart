class TalentExchangePostsFilterParam {
  final List<String>? giveTalents; // 주고픈 재능 코드
  final List<String>? receiveTalents; // 받고픈 재능 코드
  final String? order; // 정렬 - recent: 최신순, popular: 인기순
  final String? duration; // 진행 기간 - 기간 미정, 1개월, 2개월, 3개월, 3개월 이상
  final String? type; // 진행 방식 - 온라인, 오프라인, 온_오프라인
  final String? badge; // 인증 뱃지 필요 여부 - true, false
  final String? status; // 모집 상태 - 모집중, 모집_완료
  final String? page; // 기본값 1
  final String? size; // 기본값 15, 최대 50
  final String? search; // 검색어

  TalentExchangePostsFilterParam({
    this.giveTalents,
    this.receiveTalents,
    this.order,
    this.duration,
    this.type,
    this.badge,
    this.status,
    String? page,
    String? size,
    this.search,
  })  : page = page ?? '1',
        size = size ?? '15';

  TalentExchangePostsFilterParam.empty()
      : giveTalents = [],
        receiveTalents = [],
        order = null,
        duration = null,
        type = null,
        badge = null,
        status = null,
        page = '1',
        size = '15',
        search = null;

  Map<String, dynamic> toJson() {
    return {
      'giveTalents': giveTalents,
      'receiveTalents': receiveTalents,
      'order': order,
      'duration': duration,
      'type': type,
      'badge': badge,
      'status': status,
      'page': page,
      'size': size,
      'search': search,
    };
  }
}
