import 'package:wanandroid/api/wan/bean/knowledge_bean.dart';

class ChapterInfo {
  final KnowledgeBean knowledgeBean;
  final int selectIndex;

  ChapterInfo({
    required this.knowledgeBean,
    this.selectIndex = -1,
  });
}
