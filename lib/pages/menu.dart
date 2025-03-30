import 'package:flutter/material.dart';
import 'package:tester/pages/settings.dart';

class Menu extends StatelessWidget
{
  const Menu({super.key});

  void playPressed()
  {
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg2.png', 
              fit: BoxFit.cover,
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
