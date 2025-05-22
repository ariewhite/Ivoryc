import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tester/logger_wrapper.dart';
import 'package:tester/launcher.dart';
import 'package:tester/pages/login/login.dart';
import 'config.dart';


void main() async {
  await AppLogger().init();
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.instance.initialize();

 await Supabase.initialize(
    url: '', 
    anonKey: '');

  AppLogger().i("Launcher started");
  var user = await Supabase.instance.client.auth.getUser();
  
  AppLogger().i(user.user!.email.toString());
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
      home: Supabase.instance.client.auth.currentSession != null 
        ? BottomNavigation()
        : const LoginPage(),
    );
  }
}

