import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  String? id;
  String userId;
  String email;
  String bookingCode;
  String productName;
  String category;
  String bookingDate;
  String paymentDeadline;
  String paymentMethod;
  int price;
  int amount;
  int totalPrice;
  String status;

  TransactionModel({
    this.id,
    required this.userId,
    required this.email,
    required this.bookingCode,
    required this.productName,
    required this.category,
    required this.bookingDate,
    required this.paymentDeadline,
    required this.paymentMethod,
    required this.price,
    required this.amount,
    required this.totalPrice,
    required this.status,
  });

  toJson() {
    return {
      "uid": userId,
      "email": email,
      "booking-code": bookingCode,
      "product-name": productName,
      "category": category,
      "booking-date": bookingDate,
      "payment-deadline": paymentDeadline,
      "payment-method": paymentMethod,
      "price": price,
      "amount": amount,
      "total-price": totalPrice,
      "status": status,
    };
  }

  factory TransactionModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return TransactionModel(
      id: document.id,
      userId: data['uid'],
      email: data['email'],
      bookingCode: data['booking-code'],
      productName: data['product-name'],
      category: data['category'],
      bookingDate: data['booking-date'],
      paymentDeadline: data['payment-deadline'],
      paymentMethod: data['payment-method'],
      price: data['price'],
      amount: data['amount'],
      totalPrice: data['total-price'],
      status: data['status'],
    );
  }
}
