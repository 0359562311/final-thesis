import 'dart:convert';

class FilterJob {
  String? keyword;
  List<int>? categories;
  int? page;
  FilterJob({
    this.keyword,
    this.categories,
    this.page,
  });

  Map<String, dynamic> toMap() {
    return {
      'keyword': keyword,
      'categories': categories,
      'page': page,
    };
  }

  factory FilterJob.fromMap(Map<String, dynamic> map) {
    return FilterJob(
      keyword: map['keyword'],
      categories: map['categories'],
      page: map['page']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory FilterJob.fromJson(String source) =>
      FilterJob.fromMap(json.decode(source));
}
