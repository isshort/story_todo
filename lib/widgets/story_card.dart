import 'package:flutter/material.dart';
import 'package:story_todo/model/story.dart';
import 'package:story_todo/utils/image_enum.dart';

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
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  ImageEnum.part1.jpgImage,
                ),
              ),
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
                      children: storyItems?.map(
                            (e) {
                              return const CustomLinearProgressWidget();
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

class CustomLinearProgressWidget extends StatefulWidget {
  const CustomLinearProgressWidget({
    super.key,
  });

  @override
  State<CustomLinearProgressWidget> createState() =>
      _CustomLinearProgressWidgetState();
}

class _CustomLinearProgressWidgetState
    extends State<CustomLinearProgressWidget> {
  ValueNotifier<double> progressNotifier = ValueNotifier<double>(0);

  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 2),
      () {
        progressNotifier.value = progressNotifier.value + 0.5;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: SizedBox(
          height: 12,
          child: ValueListenableBuilder(
            valueListenable: progressNotifier,
            builder: (context, value, child) {
              return LinearProgressIndicator(
                value: value,
              );
            },
          ),
        ),
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
