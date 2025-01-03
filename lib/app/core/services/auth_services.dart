import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:picbudget_app/app/core/constants/url.dart';

class AuthService {
  final storage = GetStorage();

  Future<bool> checkAuthState() async {
    String? accessToken = storage.read('access');
    String? refreshToken = storage.read('refresh');
    String? userID = storage.read('user')['id'];
    var isValid = false;
    try {
      isValid = await _verifyUser(accessToken!, userID!);
    } catch (e) {
      isValid = false;
    }

    if (accessToken != null && !JwtDecoder.isExpired(accessToken) && isValid) {
      return true;
    } else if (refreshToken != null &&
        !JwtDecoder.isExpired(refreshToken) &&
        isValid) {
      return await _refreshAccessToken(refreshToken);
    }
    return false;
  }

  Future<bool> _refreshAccessToken(String refreshToken) async {
    try {
      final response = await http.post(
        Uri.parse('${UrlApi.baseAPI}/api/auth/login/refresh/'),
        body: {'refresh': refreshToken},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        saveTokens(data['access'], data['refresh']);
        return true;
      } else {
        storage.erase();
        return false;
      }
    } catch (e) {
      storage.erase();
      return false;
    }
  }

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await storage.write('access', accessToken);
    await storage.write('refresh', refreshToken);
  }

  Future<bool> _verifyUser(String accessToken, String userID) async {
    final url = '${UrlApi.baseAPI}/api/account/$userID/';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
