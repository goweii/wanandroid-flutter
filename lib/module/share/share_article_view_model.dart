import 'package:wanandroid/api/wan/wan_apis.dart';
import 'package:wanandroid/env/http/api.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/env/mvvm/view_model.dart';

class ShareArticleViewModel extends ViewModel {
  Future<dynamic> shareArticle({
    required String title,
    required String link,
  }) async {
    try {
      await WanApis.shareArticle(title: title, link: link);
      return null;
    } on ApiException catch (e) {
      return e.msg ?? Strings.current.unknown_error;
    } catch (_) {
      return Strings.current.unknown_error;
    }
  }
}
