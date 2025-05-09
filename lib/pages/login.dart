import 'package:flutter/material.dart';
import 'package:tester/config.dart';
import 'package:tester/configs/styles/decoration/app_decoration.dart';
import 'package:tester/configs/styles/text_styles/app_text_styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showOption = false;

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Авторизация',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _usernameController,
                    decoration: AppDecoration.input.standard(
                      isValid: true,
                      labelText: 'Логин',
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: AppDecoration.input.standard(
                      isValid: true,
                      labelText: 'Пароль',
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                        // обработка логина
                    },      
                    style: AppDecoration.elevated.primary().copyWith(
                      minimumSize: WidgetStateProperty.all(const Size(180, 50)),
                    ),
                    child: Text(
                      'Войти',
                      style: AppTextStyles.blackButton(),
                    ),
                  ), 
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showOption = !showOption;
                      });
                    }, 
                    style: AppDecoration.elevated.primary(),
                    child: Text(
                      'Регистрация',
                      style: AppTextStyles.blackButton(),
                    )
                  ),
                  if (showOption)
                    const Padding(
                      padding: EdgeInsets.only(top: 12.0),
                      child: Text(
                        'Дополнительные настройки...',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}
