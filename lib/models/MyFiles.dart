import 'package:flutter/material.dart';

import '../constants.dart';

class Info {
  final String? svgSrc, title, totalStorage, documentPath;
  final Color? color;

  Info({
    this.svgSrc,
    this.title,
    this.totalStorage,
    this.documentPath,
    this.color,
  });
}

List informations = [
  Info(
    title: "Active Users",
    svgSrc: "assets/icons/Documents.svg",
    color: primaryColor,
    documentPath: 'user',
  ),
  Info(
    title: "Transactions",
    svgSrc: "assets/icons/menu_tran.svg",
    color: const Color(0xFFFFA113),
    documentPath: 'transactions',
  ),
];
