import 'package:flutter/material.dart';
import 'package:tester/config.dart';
import 'package:tester/configs/styles/decoration/app_decoration.dart';



class LoginPage extends StatefulWidget{
  
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState;
  }
}

class _LoginPageState extends State<LoginPage>
{
  bool showOption = false;

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Container(
          width: 320,
          padding: const EdgeInsets.all(24.0),
          decoration: AppDecoration.button.rectangle(),
          child: Column(
            mainAxisAlignment: ,
          ),
        ),
      ),
    );
  }
}
