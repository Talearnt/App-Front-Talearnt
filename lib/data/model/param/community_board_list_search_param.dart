class CommunityBoardListSearchParam {
  final String? postType;
  final String? order;
  final String? path;
  final String? page;
  final String? size;
  final String? lastNo;

  CommunityBoardListSearchParam({
    this.postType,
    this.order,
    String? path,
    String? page,
    String? size,
    this.lastNo,
  })  : path = path ?? 'mobile',
        page = page ?? '1',
        size = size ?? '12';

  CommunityBoardListSearchParam.empty()
      : postType = null,
        order = null,
        path = 'mobile',
        page = '1',
        size = '12',
        lastNo = null;

  Map<String, dynamic> toJson() {
    return {
      'postType': postType,
      'order': order,
      'path': path,
      'page': page,
      'size': size,
      'lastNo': lastNo,
    };
  }
}
