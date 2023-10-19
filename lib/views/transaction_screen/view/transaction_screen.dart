import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../dashboard_screen/widgets/header.dart';
import '../widgets/transaction_list_widget.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            const Header(title: 'Transaction Data',),
            const SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: const [
                      TransactionListWidget(),
                    ],
                  ),
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}
