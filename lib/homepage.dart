import 'package:flutter/material.dart';
import 'package:wifi/screens/main_screens/dashboard.dart';
import 'package:wifi/screens/main_screens/network_scanner.dart';
import 'package:wifi/screens/main_screens/speed_test.dart';
import 'package:wifi/screens/main_screens/wifi_analyzer.dart';
import 'package:wifi/widget/build_nav_bar_item.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Dashboard(),
    NetworkScanner(),
    SpeedTest(),
    WifiAnalyzer(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Keep all pages alive
      body: IndexedStack(index: _currentIndex, children: _pages),
      // Floating bottom navigation
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 10 + MediaQuery.of(context).padding.bottom,
        ),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BuildNavBarItem(
                label: "dashboard",
                iconData: Icons.dashboard,
                currentIndex: _currentIndex,
                onTap: (i) {
                  setState(() {
                    _currentIndex = i;
                  });
                },
                index: 0,
              ),
              BuildNavBarItem(
                label: "Scanner",
                iconData: Icons.wifi,
                currentIndex: _currentIndex,
                onTap: (i) {
                  setState(() {
                    _currentIndex = i;
                  });
                },
                index: 1,
              ),
              BuildNavBarItem(
                label: "Speed",
                iconData: Icons.speed,
                currentIndex: _currentIndex,
                onTap: (i) {
                  setState(() {
                    _currentIndex = i;
                  });
                },
                index: 2,
              ),
              BuildNavBarItem(
                label: "Analyzer",
                iconData: Icons.analytics,
                currentIndex: _currentIndex,
                onTap: (i) {
                  setState(() {
                    _currentIndex = i;
                  });
                },
                index: 3,
              ),
              // _buildNavItem(Icons.wifi, "Scanner", 1),
              // _buildNavItem(Icons.speed, "Speed", 2),
              // _buildNavItem(Icons.analytics, "Analyzer", 3),
            ],
          ),
        ),
      ),
    );
  }
}
