import 'package:equatable/equatable.dart';

enum CollectedType {
  article,
  link,
}

// ignore: must_be_immutable
class CollectInfo extends Equatable {
  final CollectedType type;
  final String link;
  String? title;
  String? author;
  int? articleId;
  int? collectId;
  bool collected;

  CollectInfo({
    required this.type,
    required this.link,
    this.collected = false,
    this.collectId,
    this.articleId,
    this.title,
    this.author,
  });

  @override
  List<Object?> get props => [link];
}
