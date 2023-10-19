import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/views/all_user_screen/views/all_user_screen.dart';
import 'package:untitled/views/chat_screen/views/chat_home_screen.dart';
import '../../../controllers/menu_controller.dart' as mc;
import '../../../controllers/controllers.dart';
import '../../../responsive.dart';
import '../../dashboard_screen/view/dashboard_screen.dart';
import '../../transaction_screen/view/transaction_screen.dart';
import '../widgets/side_menu.dart';
import 'package:get/get.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _screens = [
    const DashboardScreen(),
    const AllUserScreen(),
    const TransactionScreen(),
    const ChatHomeScreen(),
  ];


  @override
  Widget build(BuildContext context) {
    final Controllers controller = Get.put<Controllers>(Controllers());

    return Scaffold(
      key: context.read<mc.MenuController>().scaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              const Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            // bener
            // const Expanded(
            //   // It takes 5/6 part of the screen
            //   flex: 5,
            //   child: DashboardScreen(),
            // ),
            // Expanded(
            //     flex: 5,
            //     child: Container(
            //       color: Colors.white,
            //     )),

            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: Obx(() => _screens[controller.currentIndex.value]),
              // child: TemporaryScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
