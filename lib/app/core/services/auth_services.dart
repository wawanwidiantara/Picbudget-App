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
    final user = storage.read('user');
    final userId = user?['id'];

    try {
      if (userId == null) {
        return false;
      }
    } catch (e) {
      return false;
    }

    if (accessToken != null && !JwtDecoder.isExpired(accessToken)) {
      final isValid = await _verifyToken(accessToken, userId);
      if (isValid) {
        return true;
      } else {
        return refreshToken != null &&
            await _refreshAccessToken(refreshToken, userId);
      }
    } else if (refreshToken != null && !JwtDecoder.isExpired(refreshToken)) {
      return await _refreshAccessToken(refreshToken, userId);
    }
    return false;
  }

  Future<bool> _refreshAccessToken(String refreshToken, String userId) async {
    try {
      final response = await http.post(
        Uri.parse('${UrlApi.baseAPI}/api/auth/login/refresh/'),
        body: {'refresh': refreshToken},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final newAccessToken = data['access'];
        final newRefreshToken = data['refresh'];
        storage.write('access', newAccessToken);
        storage.write('refresh', newRefreshToken);
        final isValid = await _verifyToken(newAccessToken, userId);
        if (isValid) {
          return true;
        } else {
          storage.erase();
          return false;
        }
      } else {
        storage.erase();
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await storage.write('access', accessToken);
    await storage.write('refresh', refreshToken);
  }

  Future<bool> _verifyToken(String accessToken, String userId) async {
    try {
      final response = await http.post(
        Uri.parse('${UrlApi.baseAPI}/api/account/verify/$userId/'),
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
