import 'package:flutter/material.dart';
import 'package:story_todo/model/story.dart';

import 'linear_progress.dart';

final class StoryCard extends StatefulWidget {
  const StoryCard({required this.story, required this.isTappedNext, super.key});
  final StoryModel story;
  final void Function(bool isNext) isTappedNext;

  @override
  State<StoryCard> createState() => _StoryCardState();
}

class _StoryCardState extends State<StoryCard> {
  List<StoryItems>? storyItems;

  ValueNotifier<int> currentStoryNotifier = ValueNotifier<int>(0);
  final ValueNotifier<bool> isPausedNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    storyItems = widget.story.innerStories;
  }

  void _onProgressComplete() {
    if (currentStoryNotifier.value < storyItems!.length - 1) {
      currentStoryNotifier.value++;
    } else {
      widget.isTappedNext.call(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTapUp: (details) {
    
        final size = MediaQuery.sizeOf(context).width / 2;

        /// Check if the user tapped on the right side or left side of the screen
        /// according to the screen width and the current story index to navigate
        /// to the next or previous story.
        if (storyItems != null) {
          if (details.globalPosition.dx > size) {
            if (currentStoryNotifier.value < storyItems!.length - 1) {
              currentStoryNotifier.value++;
              return;
            }
            widget.isTappedNext.call(true);
          } else {
            if (currentStoryNotifier.value > 0) {
              currentStoryNotifier.value--;
              return;
            }
            widget.isTappedNext.call(false);
          }
        }
      },

    
      child: ValueListenableBuilder(
        valueListenable: currentStoryNotifier,
        builder: (context, value, child) {
          if (storyItems == null) {
            return const Placeholder();
          }
          final currentStory = storyItems![value];
          return Container(
            decoration: BoxDecoration(
                // image: DecorationImage(
                //   fit: BoxFit.fill,
                //   image: AssetImage(
                //     ImageEnum.part1.jpgImage,
                //   ),
                // ),
                ),
            child: Stack(
              children: [
                const CloseButtonWidget(),
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: storyItems?.asMap().entries.map(
                            (entry) {
                              int index = entry.key;
                              return CustomLinearProgressWidget(
                                duration: Duration(seconds: 3),
                                isPausedNotifier: isPausedNotifier,
                                onComplete: () {
                                  if (index == currentStoryNotifier.value) {
                                    _onProgressComplete();
                                  }
                                },
                                isActive: index == currentStoryNotifier.value,
                              );
                            },
                          ).toList() ??
                          [],
                    ),
                    Text(
                      currentStory.title,
                      style: TextTheme.of(context).titleLarge,
                    ),
                    Text(
                      currentStory.description,
                      style: TextTheme.of(context).bodyLarge,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        isPausedNotifier.value = !isPausedNotifier.value;
                      },
                      child: Text('Pause/Resume'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CloseButtonWidget extends StatelessWidget {
  const CloseButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      right: 30,
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
        ),
        child: IconButton(
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.of(context).pop();
            }
          },
          icon: const Icon(
            Icons.close,
            size: 50,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
