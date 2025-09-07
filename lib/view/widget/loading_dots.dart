import 'package:app_front_talearnt/common/theme.dart';
import 'package:flutter/material.dart';

class LoadingDots extends StatefulWidget {
  final double dotSize;
  final Color color;

  const LoadingDots(
      {Key? key, this.dotSize = 8, this.color = Palette.primary01})
      : super(key: key);

  @override
  _LoadingDotsState createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<LoadingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();

    _animation1 = Tween<double>(begin: 0.1, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.0, 0.4, curve: Curves.easeInOut)),
    );
    _animation2 = Tween<double>(begin: 0.1, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.2, 0.6, curve: Curves.easeInOut)),
    );
    _animation3 = Tween<double>(begin: 0.1, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.4, 0.8, curve: Curves.easeInOut)),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildDot(Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: Container(
        width: widget.dotSize,
        height: widget.dotSize,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(color: widget.color, shape: BoxShape.circle),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildDot(_animation1),
        _buildDot(_animation2),
        _buildDot(_animation3),
      ],
    );
  }
}
