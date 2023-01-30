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

  Lecture.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        site = Site.values.byName(json['site']),
        image = json['image'],
        rate = json['rate'];
}

enum Site {
  fastcampus('패스트캠퍼스'),
  inflearn('인프런');

  const Site(this.name);
  final String name;

  String siteToString() {
    return toString().split('.').last;
  }
}
