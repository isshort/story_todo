import 'package:flutter/material.dart';
import 'package:story_todo/model/story.dart';
import 'package:story_todo/widgets/story_view.dart';
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
                  return StoryWidget(onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PageViewWidget(
                          story: StoryModel.dummyStories[index],
                        ),
                      ),
                    );
                  });
                }),
          )
        ],
      ),
    );
  }
}

final class PageViewWidget extends StatefulWidget {
  const PageViewWidget({
    super.key,
    required this.story,
  });
  final StoryModel story;
  @override
  State<PageViewWidget> createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<PageViewWidget> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
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
          body: StoryView(
            story: widget.story,
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
