class CommunityBoardListSearchParam {
  final String? postType;
  final String? order;
  final String? page;
  final String? size;
  final String? lastNo;

  CommunityBoardListSearchParam({
    this.postType,
    String? order,
    String? page,
    String? size,
    this.lastNo,
  })  : order = order ?? 'recent',
        page = page ?? '1',
        size = size ?? '12';

  CommunityBoardListSearchParam.empty()
      : postType = null,
        order = null,
        page = '1',
        size = '12',
        lastNo = null;

  Map<String, dynamic> toJson() {
    return {
      'postType': postType,
      'order': order,
      'page': page,
      'size': size,
      'lastNo': lastNo,
    };
  }
}
