import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/user_repository.dart';

class UserViewModel extends Notifier<UserModel> {
  final IUserRepository _userRepository;

  UserViewModel({
    IUserRepository? userRepository,
  }) : _userRepository = userRepository ?? UserRepository();

  @override
  UserModel build() {
    return UserModel();
  }

  Future<void> getUserProfile() async {
    try {
      final userModel = await _userRepository.getUserProfile();
      state = userModel;
    } catch (e) {
      throw Exception('사용자 정보 조회 실패: $e');
    }
  }

  Future<void> updateUserProfile(UserModel user) async {
    try {
      final updatedUser = await _userRepository.updateUserProfile(user);
      state = updatedUser;
    } catch (e) {
      throw Exception('사용자 정보 업데이트 실패: $e');
    }
  }
}

final userViewModelProvider = NotifierProvider<UserViewModel, UserModel>(() {
  return UserViewModel();
});
