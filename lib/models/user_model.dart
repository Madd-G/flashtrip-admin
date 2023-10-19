import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String username;
  final String email;
  final String gender;
  final String phoneNumber;
  // final String password;
  final String language;
  final String domicile;
  final String ktp;
  final Timestamp timestamp;

  const UserModel({
    this.id,
    required this.email,
    required this.gender,
    required this.username,
    required this.phoneNumber,
    // required this.password,
    required this.language,
    required this.domicile,
    required this.ktp,
    required this.timestamp,
  });

  toJson() {
    return {
      "username": username,
      "email": email,
      "gender": gender,
      "phone-number": phoneNumber,
      "origin": domicile,
      "ktp": ktp,
      "language": language,
      "timestamp": timestamp,
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
        email: data['email'],
        username: data['username'],
        gender: data['gender'],
        phoneNumber: data['phone-number'],
        // password: data['password'],
        language: data['language'],
        domicile: data['origin'],
        ktp: data['ktp'],
        timestamp: data['timestamp'],

    );
  }
}
