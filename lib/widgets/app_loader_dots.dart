import 'package:flutter/material.dart';
import 'package:resmpk/helpers/app_style.dart';

class AppLoaderDots extends StatefulWidget {
  final Color dotColor;
  final Duration dotDuration;

  const AppLoaderDots({
    super.key,
    this.dotColor = AppColors.black,
    this.dotDuration = const Duration(milliseconds: 1000),
  });

  @override
  AppLoaderDotsState createState() => AppLoaderDotsState();
}

class AppLoaderDotsState extends State<AppLoaderDots> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.dotDuration,
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildDot(0),
        const SizedBox(width: 10),
        _buildDot(1),
        const SizedBox(width: 10),
        _buildDot(2),
      ],
    );
  }

  Widget _buildDot(int index) {
    return ScaleTransition(
      scale: _animation.drive(
        CurveTween(
          curve: Interval((index + 1) / 3 * 0.75, 1.0, curve: Curves.easeInOut),
        ),
      ),
      child: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: widget.dotColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
