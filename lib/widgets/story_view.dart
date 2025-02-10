import 'package:flutter/material.dart';
import 'package:story_todo/model/story.dart';

final class StoryView extends StatefulWidget {
  const StoryView({super.key, required this.story, required this.isTappedNext});
  final StoryModel story;
  final void Function(bool isNext) isTappedNext;

  @override
  State<StoryView> createState() => _StoryViewState();
}

class _StoryViewState extends State<StoryView> {
  List<StoryItems>? storyItems;

  ValueNotifier<int> currentStoryNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    storyItems = widget.story.innerStories;
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTapUp: (details) {
        if (currentStoryNotifier.value < storyItems!.length - 1) {
          currentStoryNotifier.value++;
          return;
        }
        final size = MediaQuery.sizeOf(context).width / 2;
        if (details.globalPosition.dx > size) {
          widget.isTappedNext.call(true);
        } else {
          widget.isTappedNext.call(false);
        }
      },
      child: ValueListenableBuilder(
          valueListenable: currentStoryNotifier,
          builder: (context, value, child) {
            if (storyItems == null) {
              return const Placeholder();
            }
            final currentStory = storyItems![value];
            return Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  currentStory.title,
                  style: TextTheme.of(context).titleLarge,
                ),
                Text(
                  currentStory.description,
                  style: TextTheme.of(context).bodyLarge,
                ),
                Placeholder(),
              ],
            );
          }
      ),
    );
  }
}
