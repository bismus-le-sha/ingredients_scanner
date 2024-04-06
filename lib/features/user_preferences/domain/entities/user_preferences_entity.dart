import 'package:equatable/equatable.dart';

class UserPreferencesEntity extends Equatable {
  final bool cameraFlash;
  final bool useBiometrics;

  const UserPreferencesEntity(
      {required this.cameraFlash, required this.useBiometrics});

  @override
  List<Object?> get props => [cameraFlash, useBiometrics];
}
