class CommunityCommentParam {
  final String postNo;
  final String path;
  final String lastNo;
  final String page;
  final String size;

  CommunityCommentParam({
    required this.postNo,
    this.path = 'mobile',
    String lastNo = '0',
    this.page = '1',
    this.size = '10',
  }) : lastNo = lastNo == '0' ? '' : lastNo;

  Map<String, String> toJson() => {
        'postNo': postNo,
        'path': path,
        'lastNo': lastNo,
        'page': page,
        'size': size,
      };
}
