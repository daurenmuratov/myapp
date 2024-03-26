import 'package:myapp/consts.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/services/http_service.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  final _httpService = HTTPService();
  User? user;

  factory AuthService() {
    return _instance;
  }

  AuthService._internal();

  Future<bool> login(String username, String password) async {
    try {
      final response = await _httpService.post(apiLogin, {
        'username': username,
        'password': password,
      });
      if (response?.statusCode == 200 && response?.data != null) {
        user = User.fromJson(response!.data);
        HTTPService().setup(token: user!.token);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
