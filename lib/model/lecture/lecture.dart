class Lecture {
  String id, title, image, url, description;
  Site site;
  double rate;
  int reviewsCnt;
  DateTime createdAt, updatedAt;

  Lecture({
    required this.id,
    required this.title,
    required this.site,
    required this.image,
    required this.rate,
    required this.reviewsCnt,
    required this.createdAt,
    required this.updatedAt,
    required this.url,
    required this.description,
  });

  Lecture.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        site = Site.values.byName(json['site']),
        image = json['image'],
        rate = json['rate'],
        reviewsCnt = json['reviewsCnt'],
        url = json['url'],
        description = json['description'],
        createdAt = DateTime.parse(json['createdAt']),
        updatedAt = DateTime.parse(json['updatedAt']);
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
