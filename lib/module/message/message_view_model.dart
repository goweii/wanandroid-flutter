import 'package:wanandroid/api/wan/bean/message_bean.dart';
import 'package:wanandroid/api/wan/wan_apis.dart';
import 'package:wanandroid/env/http/paging.dart';
import 'package:wanandroid/env/mvvm/view_model.dart';
import 'package:wanandroid/env/provider/unread.dart';

class MsgStatablePagingData extends StatablePagingData<MessageBean> {}

class MessageViewModel extends ViewModel {
  final MsgStatablePagingData msgStatablePagingData = MsgStatablePagingData();

  final Paging<MessageBean> _unreadMsgPaging = Paging<MessageBean>(
    initialPage: 1,
    requester: (page) async {
      var resp = await WanApis.getUnreadMessages(page);
      return PagingData(ended: resp.over, datas: resp.datas);
    },
  );

  final Paging<MessageBean> _readedMsgPaging = Paging<MessageBean>(
    initialPage: 1,
    requester: (page) async {
      var resp = await WanApis.getReadedMessages(page);
      return PagingData(ended: resp.over, datas: resp.datas);
    },
  );

  Future<bool> getInitialPage() async {
    await _unreadMsgPaging.reset();
    await _readedMsgPaging.reset();
    return await getNextPage();
  }

  Future<bool> getNextPage() async {
    if (msgStatablePagingData.ended) return true;
    if (msgStatablePagingData.isLoading) return false;
    msgStatablePagingData.toLoading();
    try {
      if (!_unreadMsgPaging.isEnded) {
        var unreadList = await _unreadMsgPaging.next();
        if (_unreadMsgPaging.isInitialPage) {
          msgStatablePagingData.replace(PagingData(
            ended: false,
            datas: unreadList.datas,
          ));
          UnreadModel().unreadMsgCount -= unreadList.datas.length;
        } else {
          msgStatablePagingData.append(PagingData(
            ended: false,
            datas: unreadList.datas,
          ));
          UnreadModel().unreadMsgCount -= unreadList.datas.length;
        }
        if (_unreadMsgPaging.isEnded) {
          UnreadModel().unreadMsgCount = 0;
          getNextPage();
        }
        return true;
      }
      if (!_readedMsgPaging.isEnded) {
        var readedList = await _readedMsgPaging.next();
        msgStatablePagingData.append(readedList);
        return true;
      }
      msgStatablePagingData.toError();
      return false;
    } catch (e) {
      msgStatablePagingData.toError();
      return false;
    }
  }
}
