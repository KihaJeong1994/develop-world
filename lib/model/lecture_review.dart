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
}
