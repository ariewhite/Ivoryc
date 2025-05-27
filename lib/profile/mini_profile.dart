import 'package:flutter/material.dart';
import 'package:tester/configs/styles/text_styles/app_text_styles.dart';

class MiniProfile extends StatelessWidget {
  final String nick;
  final int hours;
  final int minutes;

  const MiniProfile({
    super.key,
    required this.nick,
    required this.hours,
    required this.minutes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nick,
                style: AppTextStyles.miniProfileNickname(),
              ),
              Row(
                children: [
                  Text(
                    '$hours',
                    style: AppTextStyles.miniProfileTime(),
                  ),
                  Text(
                    'ч.',
                    style: AppTextStyles.miniProfileTimeA(),
                  ),
                  Text(
                    '$minutes',
                    style: AppTextStyles.miniProfileTime(),
                  ),
                  Text(
                    'м.',
                    style: AppTextStyles.miniProfileTimeA(),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(width: 10),
          const CircleAvatar(
            radius: 30.0,
            backgroundImage: AssetImage(
              'assets/profile_pictures/red.jpg'
            ),
            backgroundColor: Colors.blueAccent,
          ),
        ],
      ),
    );
  }
}