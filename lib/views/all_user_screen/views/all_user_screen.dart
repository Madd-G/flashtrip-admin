import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../dashboard_screen/widgets/header.dart';
import '../widgets/user_list_widget.dart';

class AllUserScreen extends StatelessWidget {
  const AllUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            const Header(title: 'User List',),
            const SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: const [
                      UserListWidget(),
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
