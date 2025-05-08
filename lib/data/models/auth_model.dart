class AuthModel {
  final String? accessToken;
  final String? refreshToken;
  final String? provider;

  AuthModel({
    this.accessToken, // 1시간
    this.refreshToken, // 30일
    this.provider,
  });

  AuthModel copyWith({
    String? accessToken,
    String? refreshToken,
    String? provider,
  }) {
    return AuthModel(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      provider: provider ?? this.provider,
    );
  }
}
