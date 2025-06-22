class Chapter {
  final String id;
  final String title;
  final String videoUrl;
  final String description;

  Chapter({
    required this.id,
    required this.title,
    required this.videoUrl,
    required this.description,
  });
}

class Course {
  final String id;
  final String title;
  final String description;
  final String image;
  final List<Chapter> chapters;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.chapters,
  });
}
