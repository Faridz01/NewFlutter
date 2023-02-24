import 'dart:async';

import 'package:get/get.dart';
import 'package:tokoonline/app/modules/login/views/login_view.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  // final count = 0.obs;
  late Timer _pindah;

  @override
  void onInit() {
    _pindah = Timer.periodic(
      const Duration(seconds: 4),
      (timer) => Get.off(
        () => LoginView(),
        transition: Transition.leftToRight,
      ),
    );
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _pindah.cancel();
  }
  // void increment() => count.value++;
}
