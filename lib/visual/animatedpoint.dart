import 'package:flutter/material.dart';

class AnimatedDot extends StatefulWidget 
{
  final Color glowColor;
  final double glowSize;
  final double opacity;
  final Duration pulseDuration;

  const AnimatedDot({
    Key? key,
    required this.glowColor,
    this.opacity = 0.7,
    this.glowSize = 10.0,
    this.pulseDuration = const Duration(milliseconds: 1500),
  }) : super(key: key);

  @override
  _AnimatedDotState createState() => _AnimatedDotState();
}

class _AnimatedDotState extends State<AnimatedDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.pulseDuration,
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutSine,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.glowSize,
          height: widget.glowSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.glowColor.withValues(alpha: widget.opacity),
            boxShadow: [
              BoxShadow(
                color: widget.glowColor,
                blurRadius: widget.glowSize * _animation.value,
                spreadRadius: (widget.glowSize / 2) * _animation.value,
              ),
            ],
          ),
        );
      },
    );
  }
}
