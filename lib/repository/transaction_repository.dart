import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:untitled/models/transaction_model.dart';

class TransactionRepository extends GetxController {
  static TransactionRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<TransactionModel> getTransactionDetail(String email) async {
    final snapshot =
        await _db.collection("transactions").where("email", isEqualTo: email).get();
    final transactionData = snapshot.docs.map((e) => TransactionModel.fromSnapshot(e)).single;
    return transactionData;
  }

  Future<List<TransactionModel>> getAllTransaction() async {
    final snapshot = await _db
        .collection("transactions")
        .orderBy('timestamp', descending: true)
        .get();
    final transactionData = snapshot.docs.map((e) => TransactionModel.fromSnapshot(e)).toList();
    return transactionData;
  }

  Future<void> updateTransactionRecord(TransactionModel transaction) async {
    await _db.collection('transactions').doc(transaction.id).update(transaction.toJson());
  }
}
