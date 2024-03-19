import '../../domain/entities/user_preferences.dart';

class UserPreferencesModel extends UserPreferencesEntity {
  const UserPreferencesModel({
    required super.cameraFlash,
    required super.useBiometrics,
  });

  factory UserPreferencesModel.fromJson(Map<String, dynamic> json) {
    return UserPreferencesModel(
        cameraFlash: json['cameraFlash'], useBiometrics: json['useBiometrics']);
  }

  Map<String, dynamic> toJson() {
    return {"cameraFlash": cameraFlash, "useBiometrics": useBiometrics};
  }
}
