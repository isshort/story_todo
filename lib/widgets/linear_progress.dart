import 'package:flutter/material.dart';

final class CustomLinearProgressWidget extends StatefulWidget {
  final Duration duration;
  final ValueNotifier<bool> isPausedNotifier;
  final VoidCallback onComplete;
  final bool isActive;

  const CustomLinearProgressWidget({
    required this.duration,
    required this.isPausedNotifier,
    super.key,
    required this.onComplete,
    required this.isActive,
  });

  @override
  State<CustomLinearProgressWidget> createState() =>
      _CustomLinearProgressWidgetState();
}

class _CustomLinearProgressWidgetState extends State<CustomLinearProgressWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.onComplete();
        }
      });
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    widget.isPausedNotifier.addListener(_pauseProgress);
    if (widget.isActive) _controller.forward();
  }

  @override
  void didUpdateWidget(covariant CustomLinearProgressWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      _controller.reset();
      _controller.forward();
    } else if (!widget.isActive && oldWidget.isActive) {
      _controller.fling();
    }
  }

  void _pauseProgress() {
    if (widget.isPausedNotifier.value) {
      _controller.stop();
    } else {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    // widget.isPausedNotifier.removeListener(widget.onPaused);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: SizedBox(
          height: 12,
          child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return LinearProgressIndicator(
                  value: _animation.value,
                  color: Colors.blue,
                );
              }),
        ),
      ),
    );
  }
}
