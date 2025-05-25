import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:financial_management_app/screen/home_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  Widget body = const HomeScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        inactiveColor: Colors.black45,
        icons: const [Icons.home, Icons.info],
        activeIndex: currentIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.smoothEdge,
        onTap: (index) {
          if (index == 0) {
            body = const HomeScreen();
          } else {
            body = const Center(child: Text("Info"));
          }
          setState(() {
            currentIndex = index;
          });
        },
      ),
      body: body,
    );
  }
}
