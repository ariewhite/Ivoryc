import 'package:flutter/material.dart';
import 'package:tester/logger_wrapper.dart';
import 'package:tester/pages/console.dart';
import 'package:tester/pages/null.dart';
import 'package:tester/pages/settings.dart';
import 'package:tester/pages/menu.dart';
import 'package:tester/pages/update.dart';
import 'config.dart';

void main() async {
  await AppLogger().init();
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.instance.initialize();
  
  AppLogger().i("Launcher started");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ivoryc',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.cyan),
      home: BottomNavigation(),
    );
  }
}

class BottomNavigation extends StatefulWidget{
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 2;

  final List<Widget> _pages = [
    const Console(),
    const Update(),
    const Menu(),
    const Settings(),
    const EmptyPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_selectedIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.white70,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/terminal.png',
                height: 30,
                color: _selectedIndex == 0 ? Colors.blueAccent : Colors.white70,
              ),
              label: 'Console',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/update.png',
                height: 30,
                color: _selectedIndex == 1 ? Colors.blueAccent : Colors.white70,
              ),
              label: 'Update',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/play_menu.png',
                height: 30,
                color: _selectedIndex == 2? 
                  Colors.blueAccent:
                  Colors.white70,
              ),
              label: 'Play',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/settins.png',
                height: 30,
                color: _selectedIndex == 3? 
                  Colors.blueAccent:
                  Colors.white70,
              ),
              label: 'Settings',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/other.png',
                height: 30,
                color: _selectedIndex == 4? 
                  Colors.blueAccent:
                  Colors.white70,
              ),
              label: 'Other',
            ),
          ],
        )
      ),
    );
  }
}
