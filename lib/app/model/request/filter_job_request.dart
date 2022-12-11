import 'dart:convert';

class FilterJob {
  String? keyword;
  List<int>? categories;
  int? offset;
  FilterJob({
    this.keyword,
    this.categories,
    this.offset,
  });

  Map<String, dynamic> toJson() {
    return {
      'keyword': keyword,
      'categories': categories,
      'offset': offset,
    };
  }
}
