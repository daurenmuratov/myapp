import 'package:dio/dio.dart';
import 'package:myapp/consts.dart';

class HTTPService {
  static final HTTPService _instance = HTTPService._internal();
  final _dio = Dio();

  factory HTTPService() {
    return _instance;
  }

  HTTPService._internal() {
    setup();
  }

  Future<void> setup({String? token}) async {
    final headers = {
      'Content-Type': 'application/json',
    };
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    final options = BaseOptions(
      baseUrl: apiBaseUrl,
      headers: headers,
      validateStatus: (status) {
        if (status == null) return false;
        return status < 500;
      },
    );
    _dio.options = options;
  }

  Future<Response?> post(String path, Map data) async {
    try {
      final response = await _dio.post(path, data: data);
      return response;
    } on DioException catch (e) {
      return e.response;
    }
  }

  Future<Response?> get(String path) async {
    try {
      final response = await _dio.get(path);
      return response;
    } on DioException catch (e) {
      return e.response;
    }
  }
}
