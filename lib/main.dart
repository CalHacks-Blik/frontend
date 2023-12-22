import 'package:crypto_app/data/theme_data.dart';
import 'package:crypto_app/pages/chat.dart';
import 'package:crypto_app/pages/details_page.dart';
import 'package:crypto_app/pages/home_page.dart';
import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        defaultTransition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 500),
        debugShowCheckedModeBanner: false,
        title: 'Crypto App',
        home: MainPage(),
        theme: darkModeTheme,
        darkTheme: darkModeTheme,
      );
    });
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  get themeData => null;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: _currentIndex == 0 ? HomePage() : ChatPage(),
          switchInCurve: Curves.easeInOut,
          switchOutCurve: Curves.easeInOut,
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
                opacity: animation, child: child); // Use FadeTransition
          },
        ),
      ),
      bottomNavigationBar: FloatingNavbar(
        onTap: _onTabTapped,
        backgroundColor: themeData.backgroundColor,
        currentIndex: _currentIndex,
        items: [
          FloatingNavbarItem(icon: Icons.home_rounded, title: 'Home'),
          FloatingNavbarItem(icon: Icons.local_fire_department, title: 'Chat'),
        ],
      ),
    );
  }
}
