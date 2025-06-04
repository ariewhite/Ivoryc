import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tester/logger_wrapper.dart';
import 'package:tester/launcher.dart';
import 'package:tester/pages/login/login.dart';
import 'config.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppLogger().init();
  

  await Supabase.initialize(
    url: '', 
    anonKey: '');

  await AppConfig.instance.initialize();
  
  AppLogger().i("Launcher started");

  try {
    final response = await Supabase.instance.client.auth.getUser();
    final user = response.user;

    if (user != null) {
      AppLogger().i('User: ${user.toString()}');
    } else {
      AppLogger().i('No session go to login page');
    }
  } on AuthException catch (e) {
    AppLogger().i('Auth error ${e.message}');
  } catch (e, s) {
    AppLogger().e('Error: $e\n$s');
  }

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

