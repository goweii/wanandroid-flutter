import 'package:wanandroid/api/wan/wan_apis.dart';
import 'package:wanandroid/env/mvvm/view_model.dart';

class ShareArticleViewModel extends ViewModel {
  Future<String?> shareArticle({
    required String title,
    required String link,
  }) async {
    await WanApis.shareArticle(title: title, link: link);
  }
}
