import 'package:flutter/material.dart';

enum AnimationType { scale, fade }

class AnimatedGestureDetector extends StatefulWidget {
  const AnimatedGestureDetector({
    super.key,
    required this.child,
    this.animationType = AnimationType.scale,
    this.onTap,
    this.onLongTap,
    this.begin = 1.0,
    this.end = 0.98,
    this.beginDuration = const Duration(milliseconds: 20),
    this.endDuration = const Duration(milliseconds: 120),
    this.longTapRepeatDuration = const Duration(milliseconds: 100),
    this.beginCurve = Curves.decelerate,
    this.endCurve = Curves.fastOutSlowIn,
    this.behavior = HitTestBehavior.deferToChild,
    this.enableLongTapRepeatEvent = false,
  });

  final Widget child;
  final double begin;
  final double end;
  final Duration beginDuration;
  final Duration endDuration;
  final Duration longTapRepeatDuration;
  final Function()? onTap;
  final Function()? onLongTap;
  final bool enableLongTapRepeatEvent;
  final Curve beginCurve;
  final Curve endCurve;
  final HitTestBehavior behavior;
  final AnimationType animationType;

  @override
  State<AnimatedGestureDetector> createState() =>
      _AnimatedGestureDetectorState();
}

class _AnimatedGestureDetectorState extends State<AnimatedGestureDetector>
    with SingleTickerProviderStateMixin {
  //
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.endDuration,
      value: 1.0,
      reverseDuration: widget.beginDuration,
    );
    _animation = Tween(begin: widget.end, end: widget.begin).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.beginCurve,
        reverseCurve: widget.endCurve,
      ),
    );
    _controller.forward();
  }

  bool _isOnTap = true;

  Future<void> _onLongPress() async {
    await _controller.forward();
    await widget.onLongTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: widget.onLongTap != null && !widget.enableLongTapRepeatEvent
          ? _onLongPress
          : null,
      child: Listener(
        onPointerDown: (_) async {
          _isOnTap = true;
          _controller.reverse();
          if (widget.enableLongTapRepeatEvent) {
            await Future.delayed(widget.longTapRepeatDuration);
            while (_isOnTap) {
              await Future.delayed(widget.longTapRepeatDuration, () async {
                await (widget.onLongTap ?? widget.onTap)?.call();
              });
            }
          }
        },
        onPointerUp: (_) async {
          _isOnTap = false;
          await _controller.forward();
        },
        child: _buildAnimationWidget(),
      ),
    );
  }

  Widget _buildAnimationWidget() {
    switch (widget.animationType) {
      case AnimationType.scale:
        return ScaleTransition(scale: _animation, child: widget.child);
      case AnimationType.fade:
        return FadeTransition(opacity: _animation, child: widget.child);
      default:
        return ScaleTransition(scale: _animation, child: widget.child);
    }
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }
}
