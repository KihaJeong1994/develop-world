
class PageObject {
  dynamic content;
  Pageable pageable;
  bool first, last;
  int totalPages, totalElements, size;

  PageObject.fromJson(Map<String, dynamic> json)
      : content = json['content'],
        pageable = Pageable.fromJson(json['pageable']),
        first = json['first'],
        last = json['last'],
        totalPages = json['totalPages'],
        totalElements = json['totalElements'],
        size = json['size'];
}

class Pageable {
  int pageNumber;
  int pageSize;
  Pageable.fromJson(Map<String, dynamic> json)
      : pageNumber = json['pageNumber'],
        pageSize = json['pageSize'];
}
