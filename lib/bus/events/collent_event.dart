class CollectEvent {
  final int? articleId;
  final int? collectId;
  final String? articleLink;
  final bool collect;

  CollectEvent({
    this.articleId,
    this.collectId,
    this.articleLink,
    required this.collect,
  });
}
