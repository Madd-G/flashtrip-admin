import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:untitled/models/transaction_model.dart';
import '../repository/transaction_repository.dart';

class TransactionController extends GetxController {
  static TransactionController get instance => Get.find();
  final _auth = FirebaseAuth.instance.currentUser;
  final _transactionRepo = Get.put(TransactionRepository());
  // final transactionStatus = 'pending';

  getTransactionData() {
    final email = _auth!.email;
    if (email != null) {
      return _transactionRepo.getTransactionDetail(email);
    } else {
      Get.snackbar("Error", "Login to continue");
    }
  }

  Future<List<TransactionModel>> getAllTransaction() async =>
      await _transactionRepo.getAllTransaction();

  updateRecord(TransactionModel transaction) async {
    await _transactionRepo.updateTransactionRecord(transaction);
  }
}
