import 'package:dio/dio.dart';
import '../models/user_model.dart';

abstract class IUserRepository {
  Future<UserModel> getUserProfile();
  Future<UserModel> updateUserProfile(UserModel user);
}

class UserRepository implements IUserRepository {
  final Dio _dio;
  final String _baseUrl;

  UserRepository({
    Dio? dio,
    String? baseUrl,
  })  : _dio = dio ?? Dio(),
        _baseUrl = baseUrl ?? 'YOUR_NEST_SERVER_URL';

  @override
  Future<UserModel> getUserProfile() async {
    try {
      final response = await _dio.get('$_baseUrl/users/profile');

      return UserModel(
        id: response.data['id'],
        name: response.data['name'],
        profileImage: response.data['profileImage'],
        abilities: response.data['abilities'],
        interests: response.data['interests'],
        createdAt: DateTime.parse(response.data['createdAt']),
        updatedAt: DateTime.parse(response.data['updatedAt']),
      );
    } catch (e) {
      throw Exception('사용자 정보 조회 실패: $e');
    }
  }

  @override
  Future<UserModel> updateUserProfile(UserModel user) async {
    try {
      final response = await _dio.put(
        '$_baseUrl/users/profile',
        data: {
          'name': user.name,
          'profileImage': user.profileImage,
        },
      );

      return UserModel(
        id: response.data['id'],
        name: response.data['name'],
        profileImage: response.data['profileImage'],
        abilities: response.data['abilities'],
        interests: response.data['interests'],
        createdAt: DateTime.parse(response.data['createdAt']),
        updatedAt: DateTime.parse(response.data['updatedAt']),
      );
    } catch (e) {
      throw Exception('사용자 정보 업데이트 실패: $e');
    }
  }
}
