import 'package:wanandroid/api/wan/bean/link_bean.dart';
import 'package:wanandroid/api/wan/wan_apis.dart';
import 'package:wanandroid/env/mvvm/statable_data.dart';
import 'package:wanandroid/env/mvvm/view_model.dart';

class CollectedLinkStatableData extends StatableData<List<LinkBean>> {
  CollectedLinkStatableData() : super([]);
}

class CollectedLinkViewModel extends ViewModel {
  final CollectedLinkStatableData statableData = CollectedLinkStatableData();

  Future<bool> getLinks() async {
    if (statableData.isLoading) return false;
    statableData.toLoading();
    try {
      var data = await WanApis.getCollectedLinks();
      for (var e in data) {
        e.collect = true;
      }
      statableData.value = data.reversed.toList();
      return true;
    } catch (_) {
      statableData.toError();
      return false;
    }
  }

  Future<bool> deleteLink(int id) async {
    try {
      await WanApis.deleteCollectedLink(id);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> updateLink(LinkBean linkBean) async {
    try {
      await WanApis.updateCollectedLink(
        id: linkBean.id,
        name: linkBean.name,
        link: linkBean.link,
      );
      return true;
    } catch (_) {
      return false;
    }
  }
}
