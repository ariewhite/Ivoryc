import 'package:flutter/material.dart';

class Console extends StatelessWidget
{
  const Console({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/bg2.png',
            fit: BoxFit.cover,
          ),
        ),
        const Center(
          child: Text(
            "Тут будет консоль когда нибудь 😁",
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontFamily: 'Cascadia',
              fontWeight: FontWeight.normal,
            ),
          ),
        )
      ],
    );
  }
}