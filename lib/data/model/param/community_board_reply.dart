class CommunityReplyParam {
  final String commnetNO;
  final String lastNo;
  final String size;

  CommunityReplyParam({
    required this.commnetNO,
    String lastNo = '0',
    this.size = '10',
  }) : lastNo = lastNo == '0' ? '' : lastNo;

  Map<String, String> toJson() => {
        'commnetNO': commnetNO,
        'lastNo': lastNo,
        'size': size,
      };
}
