class CollectEvent {
  final int? articleId;
  final int? collectId;
  final String? link;
  final bool collect;

  CollectEvent({
    this.articleId,
    this.collectId,
    this.link,
    required this.collect,
  });
}
