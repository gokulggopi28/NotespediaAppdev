import 'package:flutter/material.dart';

class AnimatedProgressIndicator extends StatefulWidget {
  final double value;

  const AnimatedProgressIndicator({Key? key, required this.value})
      : super(key: key);

  @override
  _AnimatedProgressIndicatorState createState() =>
      _AnimatedProgressIndicatorState();
}

class _AnimatedProgressIndicatorState extends State<AnimatedProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _colorAnimation =
        ColorTween(begin: Colors.green, end: Colors.green).animate(_controller);

    // Start the animation
    _controller.forward();
  }

  @override
  void didUpdateWidget(AnimatedProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Restart the animation when the widget updates
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return CircularProgressIndicator(
          value: widget.value,
          valueColor: _colorAnimation,
          strokeWidth: 6.0,
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
