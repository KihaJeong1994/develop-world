class Lecture {
  String title, image;
  Site site;

  Lecture({
    required this.title,
    required this.site,
    required this.image,
  });
}

enum Site {
  fastcampus('패스트캠퍼스'),
  inflearn('인프런');

  const Site(this.name);
  final String name;
}
