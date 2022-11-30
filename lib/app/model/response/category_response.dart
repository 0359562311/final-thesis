class CategoryResponse {
  int? id;
  String? name;

  CategoryResponse({
    this.id,
    this.name,
  });
  CategoryResponse.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    name = json['name']?.toString();
  }
}
