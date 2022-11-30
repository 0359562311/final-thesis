import 'package:dio/dio.dart';
import 'package:fakeslink/app/model/response/category_response.dart';
import 'package:get_it/get_it.dart';

class HomeSource {
  Future<List<CategoryResponse>> getCategory() async {
    final res = (await GetIt.I<Dio>().get("/job/categories")).data;
    return (res as List).map((e) => CategoryResponse.fromJson(e)).toList();
  }
}
