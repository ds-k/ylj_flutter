import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../data/models/auth_model.dart';
import '../../data/repositories/auth_repository.dart';

enum AuthProvider {
  google,
  apple,
}

class AuthViewModel extends AsyncNotifier<AuthModel> {
  final AuthRepository _authRepository;
  final GoogleSignIn _googleSignIn;

  AuthViewModel()
      : _authRepository = AuthRepository(),
        _googleSignIn = GoogleSignIn();

  @override
  Future<AuthModel> build() async {
    return AuthModel();
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      try {
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        if (googleUser == null) {
          throw Exception('Google 로그인이 취소되었습니다.');
        }

        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final String? idToken = googleAuth.idToken;

        if (idToken == null) {
          throw Exception('ID Token을 가져오는데 실패했습니다.');
        }

        return await _authRepository.socialLogin(
            idToken, AuthProvider.google.name);
      } catch (e) {
        throw Exception('Google 로그인 실패: $e');
      }
    });
  }

  Future<void> signInWithApple() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      try {
        final credential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        );

        if (credential.identityToken == null) {
          throw Exception('Apple ID Token을 가져오는데 실패했습니다.');
        }

        return await _authRepository.socialLogin(
          credential.identityToken!,
          AuthProvider.apple.name,
        );
      } catch (e) {
        throw Exception('Apple 로그인 실패: $e');
      }
    });
  }

  Future<void> refreshToken() async {
    if (state.value?.refreshToken == null) return;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      try {
        return await _authRepository.refreshToken(state.value!.refreshToken!);
      } catch (e) {
        throw Exception('토큰 갱신 실패: $e');
      }
    });
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      try {
        await _googleSignIn.signOut();
        return AuthModel();
      } catch (e) {
        throw Exception('로그아웃 실패: $e');
      }
    });
  }
}

final authViewModelProvider =
    AsyncNotifierProvider<AuthViewModel, AuthModel>(() {
  return AuthViewModel();
});
