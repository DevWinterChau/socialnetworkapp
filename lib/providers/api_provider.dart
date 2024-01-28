import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config_env.dart';
import '../resource/tokenmanager.dart';

class ApiProvider {
  late Dio _dio;

  String? get _accessToken {
    return TokenManeger().accessToken;
  }

  static final ApiProvider _instance = ApiProvider.internal();

  factory ApiProvider() {
    return _instance;
  }

  ApiProvider.internal() {
    print(ConfigEnv.getDomainAPI);
    final baseOption = BaseOptions(baseUrl: '${ConfigEnv.getDomainAPI}');
    _dio = Dio(baseOption);
    setupInterceptors();
    (_dio.transformer as DefaultTransformer).jsonDecodeCallback =
        _parseAndDecode;
  }

  void setupInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
        if (_accessToken!.isEmpty) {
          return SharedPreferences.getInstance().then((value) {
            TokenManeger().load(value);
            options.headers['Authorization'] = 'Bearer $_accessToken';
            print("Access token sent to the server: $_accessToken");
            return handler.next(options);
          });
        }
        options.headers['Authorization'] = 'Bearer $_accessToken';
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioError e, ErrorInterceptorHandler handler) async {
        if (e.response?.statusCode == 415) {
          // Handle 415 error here
          print('HTTP 415 error: Unsupported Media Type');
          // You can throw a custom exception or handle it based on your requirements
        }
        return handler.next(e);
      },
    ));
  }

  Future<Response> get(
      String path, {
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiProgress,
      }) async {
    final res = await _dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiProgress,
    );
    if (res.statusCode == 200) {
      return res;
    }
    throw res;
  }

  Future<Response> post(
      String path, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiProgress,
        ProgressCallback? onSendProgress,
      }) async {
    final res = await _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options ?? Options(
        headers: {'Content-Type': 'application/json'},
      ),
      cancelToken: cancelToken,
      onReceiveProgress: onReceiProgress,
      onSendProgress: onSendProgress,
    );
    if (res.statusCode == 200) {
      return res;
    }
    throw res;
  }

  dynamic _parseAndDecode(String response) {
    return jsonDecode(response);
  }
}
