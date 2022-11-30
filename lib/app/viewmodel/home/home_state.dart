import 'package:fakeslink/app/model/response/category_response.dart';

enum HomeStatus { loading, error, success, initial }

class HomeState {
  final HomeStatus status;
  final List<CategoryResponse>? category;

  HomeState({required this.status, this.category});

  HomeState copyWith({HomeStatus? status, List<CategoryResponse>? category}) {
    return HomeState(
        status: status ?? this.status, category: category ?? this.category);
  }
}
