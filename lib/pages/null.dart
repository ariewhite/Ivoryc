import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget
{
  const EmptyPage({super.key});

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
            "ТУТ ПУСТО, Ожидайте обновлений 😉",
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