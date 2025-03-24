import 'package:flutter/material.dart';
import 'package:tester/pages/settings.dart';
import 'pages/menu.dart';
import 'pages/cg.dart';
import 'config.dart';

void main() async 
{
  WidgetsFlutterBinding.ensureInitialized(); // Initialize Flutter bindings

  await AppConfig.instance.readHWSpecs();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget
{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minecraft Launcher',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const MainPage(),
    );
  }
}


class MainPage extends StatefulWidget
{
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
{
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    MainPage(),
    Settings(),
    ];

    void _changePage(int index)
    {
      setState(() {
        _currentIndex = index;
      });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg1.jpg', 
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Settings()),
                    );
                  },
                  color: Colors.white,
                  iconSize: 99,
                ),
                const SizedBox(width: 40,),
                IconButton(
                  icon: const Icon(Icons.play_arrow_rounded),
                  onPressed: () {},
                  color: const Color.fromARGB(255, 0, 255, 234),
                  iconSize: 99,
                ),
                const SizedBox(width: 40,),
                IconButton(
                  icon: const Icon(Icons.update),
                  onPressed: () {},
                  color: Colors.white,
                  iconSize: 99,
                ),
              ],
            ),
          ),

          const Positioned(
            bottom: 250,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: null, 
                child: Text(
                  "Play",
                  style: TextStyle(
                    color: Colors.white
                  ),
                )),
            )
          )
        ],    
      ),
    );
  }
}