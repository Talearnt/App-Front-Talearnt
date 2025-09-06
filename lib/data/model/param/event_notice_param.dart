class EventNoticeParam {
  final String path;
  final String page;
  final String size;

  EventNoticeParam({
    this.path = 'mobile',
    this.page = '1',
    this.size = '10',
  });

  Map<String, String> toJson() => {
        'path': path,
        'page': page,
        'size': size,
      };
}
