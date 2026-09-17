import 'package:shinobi_desk/features/auth/data/models/app_user_model.dart';

class AuthSessionModel {
  final String accessToken;
  final String refreshToken;
  final AppUserModel user;

  const AuthSessionModel({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory AuthSessionModel.fromJson(Map<String, dynamic> json) {
    return AuthSessionModel(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      user: AppUserModel.fromJson(json['user']),
    );
  }
}
