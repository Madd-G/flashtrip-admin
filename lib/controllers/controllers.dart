import 'package:get/get.dart';

class Controllers extends GetxController {
  static Controllers get instance => Get.find();

  RxInt currentIndex = 0.obs;
  RxString currentStatus = ''.obs;
}
