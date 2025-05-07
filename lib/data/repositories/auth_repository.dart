import 'package:dio/dio.dart';
import '../models/auth_model.dart';

class AuthRepository {
  final Dio _dio;
  final String _baseUrl = 'YOUR_NEST_SERVER_URL';

  AuthRepository() : _dio = Dio();

  Future<AuthModel> socialLogin(String token, String provider) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/auth/social-login',
        data: {
          'token': token,
          'provider': provider,
        },
      );

      return AuthModel(
        accessToken: response.data['accessToken'],
        refreshToken: response.data['refreshToken'],
        provider: provider,
        isAuthenticated: true,
        tokenExpiry: DateTime.parse(response.data['expiresAt']),
      );
    } catch (e) {
      throw Exception('소셜 로그인 실패: $e');
    }
  }

  Future<AuthModel> refreshToken(String refreshToken) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/auth/refresh',
        data: {
          'refreshToken': refreshToken,
        },
      );

      return AuthModel(
        accessToken: response.data['accessToken'],
        refreshToken: response.data['refreshToken'],
        isAuthenticated: true,
        tokenExpiry: DateTime.parse(response.data['expiresAt']),
      );
    } catch (e) {
      throw Exception('토큰 갱신 실패: $e');
    }
  }
}
