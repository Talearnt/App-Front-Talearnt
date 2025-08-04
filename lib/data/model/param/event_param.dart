class EventParam {
  final String path;
  final String page;
  final String size;

  EventParam({
    this.path = 'mobile',
    this.page = '1',
    this.size = '15',
  });

  Map<String, String> toJson() => {
        'path': path,
        'page': page,
        'size': size,
      };
}
