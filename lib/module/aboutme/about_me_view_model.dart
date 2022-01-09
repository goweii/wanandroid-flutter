import 'package:wanandroid/api/com/bean/about_me_bean.dart';
import 'package:wanandroid/api/com/com_apis.dart';
import 'package:wanandroid/env/mvvm/statable_data.dart';
import 'package:wanandroid/env/mvvm/view_model.dart';

class AboutMeStatableData extends StatableData<AboutMeBean?> {
  AboutMeStatableData() : super(null);
}

class AboutMeViewModel extends ViewModel {
  final AboutMeStatableData statableData = AboutMeStatableData();

  Future<bool> getAboutMeInfo() async {
    statableData.toLoading();
    try {
      statableData.value = await ComApis.getAboutMeInfo();
      return true;
    } catch (_) {
      statableData.toError();
      return false;
    }
  }
}
