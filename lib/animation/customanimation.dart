import 'package:flutter/material.dart';

class CustomAnimatedWidget extends StatefulWidget {
  final Offset beginOffset;
  final Offset endOffset;
  final Duration duration;
  final Duration  delay; // Add delay duration
  final Curve curve;
  final Widget child;

  const CustomAnimatedWidget({
    Key? key,
    required this.beginOffset,
    required this.endOffset,
    required this.duration,
    this.delay = Duration.zero, // Default delay is zero
    this.curve = Curves.easeOut,
    required this.child,
  }) : super(key: key);

  @override
  _CustomAnimatedWidgetState createState() => _CustomAnimatedWidgetState();
}

class _CustomAnimatedWidgetState extends State<CustomAnimatedWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = Tween<Offset>(
      begin: widget.beginOffset,
      end: widget.endOffset,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      ),
    );

    // Add delay before starting the animation
    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: widget.child,
    );
  }
}
