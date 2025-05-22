import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tester/config.dart';
import 'package:tester/configs/styles/decoration/app_decoration.dart';
import 'package:tester/configs/styles/text_styles/app_text_styles.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLogin = true;

  final supabase = Supabase.instance.client;

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          const Positioned.fill(
            child: Image(
              image: AssetImage('assets/images/bg2.png'),
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Container(
                width: 320,
                padding: const EdgeInsets.all(24.0),
                decoration: AppDecoration.button.rectangle(),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  transitionBuilder: (child, animation) {
                    final offsterAnimation = Tween<Offset>(
                            begin: const Offset(0.0, 0.1), // from down to up
                            end: Offset.zero)
                        .animate(animation);

                    return SlideTransition(
                      position: offsterAnimation,
                      child: FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    );
                  },
                  child: isLogin ? _buildLoginPage() : _buildRegistrationPage(),
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginPage() {
    return Column(
      key: const ValueKey('login'),
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Авторизация',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        const SizedBox(height: 16),
        TextField(
          controller: _usernameController,
          decoration:
              AppDecoration.input.standard(isValid: true, labelText: "Логин"),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _passwordController,
          obscureText: true,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => _auth(),
          decoration:
              AppDecoration.input.standard(isValid: true, labelText: "Пароль"),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            _auth();
          },
          style: AppDecoration.elevated.primary(),
          child: Text('Войти', style: AppTextStyles.blackButton()),
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () {
            setState(() {
              isLogin = false;
            });
          },
          child: const Text('Нет аккаунта? Зарегистрироваться',
              style: TextStyle(color: Colors.black)),
        )
      ],
    );
  }

  Widget _buildRegistrationPage() {
    return Column(
      key: const ValueKey("register"),
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Авторизация',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        const SizedBox(height: 16),
        TextField(
          controller: _emailController,
          decoration:
              AppDecoration.input.standard(isValid: true, labelText: "Почта"),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _usernameController,
          decoration:
              AppDecoration.input.standard(isValid: true, labelText: "Логин"),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _passwordController,
          obscureText: true,
          textInputAction: TextInputAction.done,
          onSubmitted: (value) => _auth(),
          decoration:
              AppDecoration.input.standard(isValid: true, labelText: "Пароль"),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            _createAccount();
          },
          style: AppDecoration.elevated.primary(),
          child: Text('Создать аккаунт', style: AppTextStyles.blackButton()),
        ),
        const SizedBox(height: 12),
        TextButton(
            onPressed: () {
              setState(() {
                isLogin = true;
              });
            },
            child: const Text('Уже есть аккаунт? Войти',
                style: TextStyle(color: Colors.black)))
      ],
    );
  }

  Future<bool> _auth() async {
    try {
      final supabase = Supabase.instance.client;

      final res = await supabase.auth.signInWithPassword(
        email: _usernameController.text.trim(),
        password: _passwordController.text.trim(),
      );

      final Session? session = res.session;
      final User? user = res.user;

      debugPrint('Успешный вход: ${user?.email}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(
            child: Text(
              'Успех!',
              style: TextStyle(
                fontFamily: 'Cascadia',
                color: Colors.black,
              )
            )
          ),
          duration: Durations.long2,
          backgroundColor: Colors.white70,
      ),);

      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => BottomNavigation()),
      // );
      return true; 
    } 
    on AuthException catch (e) {
      debugPrint("error while auth: ${e.message}");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(
            child: Text(
              'Ошибка при авторизации!',
              style: TextStyle(
                fontFamily: 'Cascadia',
                color: Colors.black,
              )
            )
          ),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.white70,
      ),);
      return false;
    } catch (e) { 
      debugPrint('Неизвестная ошибка: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Произошла ошибка, попробуйте позже')),
      );
      return false;
    }
  }

  Future<bool> _createAccount() async {
    try {
      final supabase = Supabase.instance.client;
    
      final AuthResponse res = await supabase.auth.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      final User? user = res.user;

      debugPrint('new user: ${user!.email}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(
            child: Text(
              'Успех! Ожидайте письмо.',
              style: TextStyle(
                fontFamily: 'Cascadia',
                color: Colors.black,
              )
            )
          ),
          duration: Durations.long2,
          backgroundColor: Colors.white70,
      ),);
    } 
    catch (e) {
      debugPrint('Неизвестная ошибка: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Произошла ошибка, попробуйте позже',
            style: TextStyle(
              fontFamily: 'Cascadia',
              color: Colors.black,
            ),
          ),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.white70,
        ),
      );
      return false;
    }
    

    return false;
  }

}
