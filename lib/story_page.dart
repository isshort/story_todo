import 'package:flutter/material.dart';
import 'package:story_todo/model/story.dart';
import 'package:story_todo/widgets/story_card.dart';

final class StoryPage extends StatefulWidget {
  const StoryPage({
    required this.initialPage,
    super.key,
  });
  final int initialPage;
  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: widget.initialPage,
    );
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      itemCount: StoryModel.dummyStories.length,
      itemBuilder: (context, index) {
        return Scaffold(
          body: StoryCard(
            story: StoryModel.dummyStories[index],
            onNextStory: (isNext) {
              if (isNext) {
                pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              } else {
                pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              }
            },
            onStoryFinished: () {
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }
}
