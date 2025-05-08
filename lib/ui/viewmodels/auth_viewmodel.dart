import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../data/models/auth_model.dart';
import '../../data/repositories/auth_repository.dart';

enum AuthProvider {
  google,
  apple,
}

class AuthViewModel extends Notifier<AuthModel> {
  final IAuthRepository _authRepository;
  final GoogleSignIn _googleSignIn;

  AuthViewModel({
    IAuthRepository? authRepository,
    GoogleSignIn? googleSignIn,
  })  : _authRepository = authRepository ?? AuthRepository(),
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  @override
  AuthModel build() {
    return AuthModel();
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Google 로그인이 취소되었습니다.');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final String? idToken = googleAuth.idToken;

      print(idToken);
      if (idToken == null) {
        throw Exception('ID Token을 가져오는데 실패했습니다.');
      }

      final auth =
          await _authRepository.socialLogin(idToken, AuthProvider.google.name);
      state = auth;
    } catch (e) {
      throw Exception('Google 로그인 실패: $e');
    }
  }

  Future<void> signInWithApple() async {
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

      final auth = await _authRepository.socialLogin(
        credential.identityToken!,
        AuthProvider.apple.name,
      );
      state = auth;
    } catch (e) {
      throw Exception('Apple 로그인 실패: $e');
    }
  }

  Future<void> refreshToken() async {
    if (state.refreshToken == null) return;

    try {
      final auth = await _authRepository.refreshToken(state.refreshToken!);
      state = auth;
    } catch (e) {
      throw Exception('토큰 갱신 실패: $e');
    }
  }

  Future<void> logout() async {
    try {
      await _googleSignIn.signOut();
      state = AuthModel();
    } catch (e) {
      throw Exception('로그아웃 실패: $e');
    }
  }
}

final authViewModelProvider = NotifierProvider<AuthViewModel, AuthModel>(() {
  return AuthViewModel();
});
