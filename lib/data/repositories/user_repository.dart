import 'package:dio/dio.dart';
import '../models/user_model.dart';

class UserRepository {
  final Dio _dio;
  final String _baseUrl = 'YOUR_NEST_SERVER_URL';

  UserRepository() : _dio = Dio();

  Future<UserModel> getUserProfile() async {
    try {
      final response = await _dio.get('$_baseUrl/users/profile');

      return UserModel(
        id: response.data['id'],
        email: response.data['email'],
        name: response.data['name'],
        profileImage: response.data['profileImage'],
        phoneNumber: response.data['phoneNumber'],
        createdAt: DateTime.parse(response.data['createdAt']),
        updatedAt: DateTime.parse(response.data['updatedAt']),
      );
    } catch (e) {
      throw Exception('사용자 정보 조회 실패: $e');
    }
  }

  Future<UserModel> updateUserProfile(UserModel user) async {
    try {
      final response = await _dio.put(
        '$_baseUrl/users/profile',
        data: {
          'name': user.name,
          'phoneNumber': user.phoneNumber,
          'profileImage': user.profileImage,
        },
      );

      return UserModel(
        id: response.data['id'],
        email: response.data['email'],
        name: response.data['name'],
        profileImage: response.data['profileImage'],
        phoneNumber: response.data['phoneNumber'],
        createdAt: DateTime.parse(response.data['createdAt']),
        updatedAt: DateTime.parse(response.data['updatedAt']),
      );
    } catch (e) {
      throw Exception('사용자 정보 업데이트 실패: $e');
    }
  }
}
