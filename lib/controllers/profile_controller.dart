import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';
import '../repository/user_repository.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();
  final _auth = FirebaseAuth.instance.currentUser;
  final _userRepo = Get.put(UserRepository());

  getUserData() {
    final email = _auth!.email;
    if (email != null) {
      return _userRepo.getUserDetail(email);
    } else {
      Get.snackbar("Error", "Login to continue");
    }
  }

  Future<List<UserModel>> getAllUser() async {
    return await _userRepo.getAllUser();
  }
}
