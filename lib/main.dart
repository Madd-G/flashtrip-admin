import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:untitled/custom_scroll.dart';
import 'package:untitled/views/dashboard_screen/view/dashboard_screen.dart';
import 'package:untitled/views/login_screen/views/login_screen.dart';
import 'package:untitled/views/main_screen/views/main_screen.dart';
import 'constants.dart';
import 'controllers/menu_controller.dart' as mc;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyAf9nLvK9I4EARLpWSMyRnCactb3FB7L2c",
    projectId: "flashtrip-43016",
    messagingSenderId: "758475580274",
    appId: "1:758475580274:web:2f9b093cc62cae7c80b3eb",
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => mc.MenuController(),
        ),
      ],
      child: GetMaterialApp(
        scrollBehavior: MyCustomScrollBehavior(),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Admin Panel',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mainColor,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.white),
          canvasColor: secondaryColor,
        ),
        home: const MainScreen(),
      ),
    );
  }
}
