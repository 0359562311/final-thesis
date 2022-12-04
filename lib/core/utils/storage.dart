import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class StorageService {
  static Future<String> uploadFile(File file) async {
    final data =
        FormData.fromMap({"file": await MultipartFile.fromFile(file.path)});
    return GetIt.I<Dio>()
        .post("/storage/", data: data)
        .then((value) => value.data);
  }
}
