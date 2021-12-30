import 'package:json_annotation/json_annotation.dart';
import 'package:wanandroid/api/bean/tag_bean.dart';

part 'article_bean.g.dart';

@JsonSerializable()
class ArticleBean {
  final String? apkLink;
  final int audit;
  final String? author;
  final bool canEdit;
  final int chapterId;
  final String? chapterName;
  final bool collect;
  final int courseId;
  final String? desc;
  final String? descMd;
  final String? envelopePic;
  final bool fresh;
  final String? host;
  final int id;
  final String? link;
  final String? niceDate;
  final String? niceShareDate;
  final String? origin;
  final String? prefix;
  final String? projectLink;
  final int publishTime;
  final int realSuperChapterId;
  final int selfVisible;
  final int shareDate;
  final String? shareUser;
  final int superChapterId;
  final String? superChapterName;
  final List<TagBean>? tags;
  final String? title;
  final int type;
  final int userId;
  final int visible;
  final int zan;

  ArticleBean({
    required this.apkLink,
    required this.audit,
    required this.author,
    required this.canEdit,
    required this.chapterId,
    required this.chapterName,
    required this.collect,
    required this.courseId,
    required this.desc,
    required this.descMd,
    required this.envelopePic,
    required this.fresh,
    required this.host,
    required this.id,
    required this.link,
    required this.niceDate,
    required this.niceShareDate,
    required this.origin,
    required this.prefix,
    required this.projectLink,
    required this.publishTime,
    required this.realSuperChapterId,
    required this.selfVisible,
    required this.shareDate,
    required this.shareUser,
    required this.superChapterId,
    required this.superChapterName,
    required this.tags,
    required this.title,
    required this.type,
    required this.userId,
    required this.visible,
    required this.zan,
  });

  factory ArticleBean.fromJson(Map<String, dynamic> json) =>
      _$ArticleBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleBeanToJson(this);
}
