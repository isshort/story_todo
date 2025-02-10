import 'package:flutter/material.dart';
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
                itemCount: 4,
                itemBuilder: (context, index) {
                  return StoryWidget(onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PageViewWidget(),
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
  });

  @override
  State<PageViewWidget> createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<PageViewWidget> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: 1,
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
      itemCount: 4,
      itemBuilder: (context, index) {
        return Scaffold(
          body: StoryView(
            page: index,
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
