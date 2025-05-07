class AuthModel {
  final String? accessToken;
  final String? refreshToken;
  final String? provider;
  final bool isAuthenticated;
  final DateTime? tokenExpiry;

  AuthModel({
    this.accessToken,
    this.refreshToken,
    this.provider,
    this.isAuthenticated = false,
    this.tokenExpiry,
  });

  AuthModel copyWith({
    String? accessToken,
    String? refreshToken,
    String? provider,
    bool? isAuthenticated,
    DateTime? tokenExpiry,
  }) {
    return AuthModel(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      provider: provider ?? this.provider,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      tokenExpiry: tokenExpiry ?? this.tokenExpiry,
    );
  }
}
