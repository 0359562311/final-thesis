import 'package:fakeslink/app/model/entities/category.dart';

enum HomeStatus { loading, error, success, initial }

class HomeState {
  final HomeStatus status;
  final List<Category>? category;
  int currentTab;

  HomeState({required this.status, this.category, this.currentTab = 0});

  HomeState copyWith({
    HomeStatus? status,
    List<Category>? category,
    int? currentTab,
  }) {
    return HomeState(
      status: status ?? this.status,
      category: category ?? this.category,
      currentTab: currentTab ?? this.currentTab,
    );
  }
}
