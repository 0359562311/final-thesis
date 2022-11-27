import 'dart:async';

import 'package:dio/dio.dart';
import 'package:fakeslink/core/const/api_path.dart';
import 'package:fakeslink/main.dart';
import 'package:get_it/get_it.dart';

class AuthenticationInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (configBox.get("session") != null &&
        !options.path.contains(APIPath.logIn)) {
      options.headers['Authorization'] =
          "Bearer ${configBox.get("session").access}";
    }
    handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.type == DioErrorType.connectTimeout ||
        err.type == DioErrorType.receiveTimeout ||
        err.type == DioErrorType.sendTimeout) {
      GetIt.instance<StreamController<String>>().add("Quá thời gian kết nối.");
      // if (err.requestOptions.path.contains(APIPath.me) ||
      //     err.requestOptions.path.contains(APIPath.listSchedules))
      err.response?.data = err.response?.data['data'];
      handler.next(err);
    } else if (err.response?.requestOptions.path.startsWith("/auth") ?? true) {
      err.response?.data = err.response?.data['data'];
      handler.next(err);
    } else if (err.response?.statusCode == 401) {
      var dio = GetIt.instance<Dio>();
      dio.interceptors.requestLock.lock();
      dio.interceptors.responseLock.lock();
      dio.interceptors.errorLock.lock();

      RequestOptions options = err.requestOptions;
      await Dio()
          .post(
        options.baseUrl + "/auth/jwt/refresh/",
        // data: {"refresh": GetIt.instance<Session>().refresh},
      )
          .then((value) async {
        // if (GetIt.instance.isRegistered<Session>())
        //   GetIt.instance.unregister<Session>();
        // GetIt.instance.registerSingleton<Session>(
        //     SessionModel.fromJson(value.data['data']));
        var queryParams = options.queryParameters;
        var data = options.data;
        await Dio()
            .request(options.baseUrl + options.path,
                queryParameters: queryParams,
                data: data,
                options: Options(headers: {
                  // 'Authorization': "Bearer ${GetIt.instance<Session>().access}"
                }, method: options.method))
            .then((value) {
          dio.interceptors.responseLock.unlock();
          dio.interceptors.requestLock.unlock();
          dio.interceptors.errorLock.unlock();
          print("value from interceptor $value");
          handler.resolve(value..data = value.data['data']);
        }).catchError((error) {
          dio.interceptors.responseLock.unlock();
          dio.interceptors.requestLock.unlock();
          dio.interceptors.errorLock.unlock();
          err.response?.data = err.response?.data['data'];
          handler.reject(error);
        });
      }).catchError((error) {
        if (error is DioError && error.response?.statusCode == 401) {
          dio.clear();
          dio.interceptors.responseLock.unlock();
          dio.interceptors.requestLock.unlock();
          dio.interceptors.errorLock.unlock();
          if (GetIt.instance.isRegistered<StreamController<String>>()) {
            GetIt.instance<StreamController<String>>()
                .add("Phiên đăng nhập đã hết.");
          }
        } else {
          err.response?.data = err.response?.data['data'];
          handler.next(err);
        }
      });
    } else {
      if (err.response?.data is Map)
        err.response?.data = err.response?.data['data'];
      handler.next(err);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }
}
