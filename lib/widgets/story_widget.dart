import 'package:flutter/material.dart';

final class StoryWidget extends StatelessWidget {
  const StoryWidget({
    super.key,
    this.onTap,
  });
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Padding(
        padding: EdgeInsets.all(2),
        child: CircleAvatar(
          radius: 40,
          child: FlutterLogo(size: 50),
        ),
      ),
    );
  }
}
