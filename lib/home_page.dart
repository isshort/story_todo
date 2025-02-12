import 'package:flutter/material.dart';
import 'package:story_todo/model/story.dart';
import 'package:story_todo/story_page.dart';
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
                        builder: (context) => StoryPage(
                          initialPage: index,
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

