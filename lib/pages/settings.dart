import 'package:flutter/material.dart';

class Settings extends StatelessWidget{
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Image.asset(
        'assets/images/bg2.png',
        fit: BoxFit.cover,
      ));
  }
}