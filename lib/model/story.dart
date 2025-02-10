final class StoryModel {
  final int storyId;
  final String url;
  final bool isViewed;
  final List<StoryItems> innerStories;
  const StoryModel({
    required this.storyId,
    required this.url,
    required this.isViewed,
    required this.innerStories,
  });
  static final dummyStories = [
    StoryModel(
      storyId: 1,
      url: 'First view',
      isViewed: false,
      innerStories: [
        StoryItems(
          id: 1,
          url: 'https://images.unsplash.com/photo-1612838320302-4b3b3b3b3b3b',
          title: 'Story1 Title 1',
          description: 'Description 1',
          type: StoryType.text,
        ),
        StoryItems(
          id: 2,
          url: 'https://images.unsplash.com/photo-1612838320302-4b3b3b3b3b3b',
          title: 'Story2 Title 2',
          description: 'Description 2',
          type: StoryType.text,
        ),
      ],
    ),
    StoryModel(
      storyId: 2,
      url: 'https://images.unsplash.com/photo-1612838320302-4b3b3b3b3b3b',
      isViewed: false,
      innerStories: [
        StoryItems(
          id: 1,
          url: 'https://images.unsplash.com/photo-1612838320302-4b3b3b3b3b3b',
          title: 'Story2 Title 1',
          description: 'Description 1',
          type: StoryType.text,
        ),
        StoryItems(
          id: 2,
          url: 'https://images.unsplash.com/photo-1612838320302-4b3b3b3b3b3b',
          title: 'Story2 Title 2',
          description: 'Description 2',
          type: StoryType.text,
        ),
      ],
    )
  ];
}

final class StoryItems {
  final int id;
  final String url;
  final String title;
  final String description;
  final StoryType type;

  const StoryItems(
      {required this.id,
      required this.url,
      required this.title,
      required this.description,
      required this.type});
}

enum StoryType {
  image,
  video,
  text,
}
