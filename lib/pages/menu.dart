import 'package:flutter/material.dart';
import 'package:tester/config.dart';
import 'package:tester/visual/animatedpoint.dart';
import 'package:tester/profile/mini_profile.dart';

class Menu extends StatelessWidget
{
  const Menu({super.key});

  void playPressed()
  {
    
  }

  Color getVesionGlowColor()
  {
    if (AppConfig.instance.packVersion == AppConfig.instance.gPackVersion)
    {
      return Colors.lightGreen;
    } 
    return Colors.deepOrange;
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
                )
              ),
            )
          ),

          Positioned(
            bottom: 210,
            left: 0,
            right: 0,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppConfig.instance.packVersion, // pack version text
                    style: const TextStyle(
                      color: Colors.white60,
                      fontFamily: 'Cascadia',
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(width: 8),
                  AnimatedDot(
                    glowColor: getVesionGlowColor(),
                    glowSize: 5.0,
                    opacity: 0.4,
                  ),
                ],
              )  
            ),
          ),
          Positioned(
            right: 25,
            top: 25,
            child: MiniProfile(
              hours: 2,
              minutes: 20,
              nick: AppConfig.instance.nickname,
            ),
          ),
        ],    
      ),
    );
  }
}

