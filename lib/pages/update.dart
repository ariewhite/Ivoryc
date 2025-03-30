import 'package:flutter/material.dart';

class Update extends StatelessWidget
{
  const Update({super.key});

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
            'Скоро тут будет центр обновлений 😶‍🌫️',
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