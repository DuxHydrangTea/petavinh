import 'package:get/get.dart';

class ProfileController extends GetxController {
  int selectTab = 0;
  @override
  // ignore: unnecessary_overrides
  void onInit() {
    super.onInit();
  }

  @override
  // ignore: unnecessary_overrides
  void onClose() {
    super.onClose();
  }

  changeSelectTab(int id) {
    selectTab = id;
    update();
  }
}
