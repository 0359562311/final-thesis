import 'package:fakeslink/app/model/data_sources/home_source.dart';
import 'package:fakeslink/app/model/response/category_response.dart';

mixin HomeRepository {
  Future<List<CategoryResponse>> getCategory();
}

class HomeRepositoryImpl implements HomeRepository {
  final HomeSource _homeSource = HomeSource();
  @override
  Future<List<CategoryResponse>> getCategory() {
    return _homeSource.getCategory();
  }
}
