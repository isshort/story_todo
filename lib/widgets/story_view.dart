import 'package:flutter/material.dart';

final class StoryView extends StatelessWidget {
  const StoryView({super.key, required this.page, required this.isTappedNext});
  final int page;
  final void Function(bool isNext) isTappedNext;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('ontap');
      },
      onTapUp: (details) {
        final size = MediaQuery.sizeOf(context).width / 2;
        if (details.globalPosition.dx > size) {
          isTappedNext.call(true);
        } else {
          isTappedNext.call(false);
        }
      },
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            'Page number $page',
            style: TextTheme.of(context).titleLarge,
          ),
          Placeholder(),
        ],
      ),
    );
  }
}
