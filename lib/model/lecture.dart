class Lecture {
  String title, image;
  Site site;
  double rate;

  Lecture({
    required this.title,
    required this.site,
    required this.image,
    required this.rate,
  });
}

enum Site {
  fastcampus('패스트캠퍼스'),
  inflearn('인프런');

  const Site(this.name);
  final String name;
}
