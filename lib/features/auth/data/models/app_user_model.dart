import 'package:shinobi_desk/features/auth/domain/entities/app_user.dart';

class AppUserModel extends AppUser {
  const AppUserModel({required super.id, required super.email});

  factory AppUserModel.fromJson(Map<String, dynamic> json) {
    return AppUserModel(id: json['id'], email: json['email']);
  }
}
