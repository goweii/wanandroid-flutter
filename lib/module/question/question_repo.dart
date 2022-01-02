import 'package:wanandroid/api/bean/article_bean.dart';
import 'package:wanandroid/env/http/paging.dart';
import 'package:wanandroid/api/wan_apis.dart';

class QuestionRepo {
  final Paging<ArticleBean> _questionPaging = Paging<ArticleBean>(
    initialPage: 1,
    requester: (page) async {
      var resp = await WanApis.getQuestions(page);
      return PagingData(ended: resp.over, datas: resp.datas);
    },
  );

  Future<PagingData<ArticleBean>> getInitialPageQuestions() async {
    await _questionPaging.reset();
    return _questionPaging.next();
  }

  Future<PagingData<ArticleBean>> getNextPageQuestions() async {
    return _questionPaging.next();
  }
}
