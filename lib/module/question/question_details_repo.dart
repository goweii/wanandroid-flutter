import 'package:wanandroid/env/http/paging.dart';
import 'package:wanandroid/api/wan/wan_apis.dart';
import 'package:wanandroid/api/wan/bean/question_commen_bean.dart';

class QuestionDetailsRepo {
  final int questionId;
  final Paging<QuestionCommentBean> _commentPaging;

  QuestionDetailsRepo(this.questionId)
      : _commentPaging = Paging<QuestionCommentBean>(
          initialPage: 0,
          requester: (page) async {
            var resp = await WanApis.getQuestionComments(
              questionId: questionId,
              page: page,
            );
            // 取出子评论，暂时不做样式处理
            List<QuestionCommentBean> list = _spreadOutComments(resp.datas);
            return PagingData(ended: true, datas: list);
          },
        );

  static List<QuestionCommentBean> _spreadOutComments(
      List<QuestionCommentBean> datas) {
    List<QuestionCommentBean> list = [];
    for (var data in datas) {
      list.add(data);
      if (data.replyComments.isNotEmpty) {
        var subList = _spreadOutComments(data.replyComments);
        list.addAll(subList);
      }
    }
    return list;
  }

  Future<PagingData<QuestionCommentBean>> getInitialPageComments() async {
    await _commentPaging.reset();
    return _commentPaging.next();
  }

  Future<PagingData<QuestionCommentBean>> getNextPageComments() async {
    return _commentPaging.next();
  }
}
