class LectureReview {
  String? id, lectureId;
  String review, createdBy;
  double rate;
  DateTime createdAt, updatedAt;

  LectureReview({
    required this.id,
    required this.lectureId,
    required this.createdBy,
    required this.review,
    required this.rate,
    required this.createdAt,
    required this.updatedAt,
  });

  LectureReview.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        lectureId = json['lectureId'],
        createdBy = json['createdBy'],
        review = json['review'],
        rate = json['rate'],
        createdAt = DateTime.parse(json['createdAt']),
        updatedAt = DateTime.parse(json['updatedAt']);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lectureId': lectureId,
      'createdBy': createdBy,
      'review': review,
      'rate': rate,
    };
  }
}
