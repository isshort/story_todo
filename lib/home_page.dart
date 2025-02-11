import 'package:flutter/material.dart';
import 'package:story_todo/model/story.dart';
import 'package:story_todo/widgets/story_card.dart';
import 'package:story_todo/widgets/story_widget.dart';

final class HomePage extends StatelessWidget {
  const HomePage({super.key});
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: StoryModel.dummyStories.length,
              itemBuilder: (context, index) {
                return StoryWidget(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<bool>(
                        builder: (context) => PageViewWidget(
                          initialPage: index,
                          // selectedStory: StoryModel.dummyStories[index],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

}

final class PageViewWidget extends StatefulWidget {
  const PageViewWidget({
    required this.initialPage,
    super.key,
  });
  final int initialPage;
  @override
  State<PageViewWidget> createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<PageViewWidget> {
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
            isTappedNext: (isNext) {
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
          ),
        );
      },
    );
  }
}
