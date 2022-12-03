import 'package:dio/dio.dart';
import 'package:fakeslink/app/model/entities/category.dart';
import 'package:get_it/get_it.dart';

class JobRemoteSource {
  Future<List<Category>> getCategory() async {
    final res = (await GetIt.I<Dio>().get("/job/categories")).data;
    return (res as List).map((e) => Category.fromJson(e)).toList();
  }
}
