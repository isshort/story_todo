import 'package:flutter/material.dart';

class CustomLinearProgressWidget extends StatefulWidget {
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

    widget.isPausedNotifier.addListener(_pauseProgress);
    if (widget.isActive) _controller.forward();
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
    widget.isPausedNotifier.removeListener(_pauseProgress);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: SizedBox(
          height: 12,
          child: LinearProgressIndicator(
            value: _controller.value,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
