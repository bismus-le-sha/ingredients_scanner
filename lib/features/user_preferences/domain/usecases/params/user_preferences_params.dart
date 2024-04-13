import 'package:equatable/equatable.dart';
import '../../../data/models/user_preferences_model.dart';

class UserPreferencesParams extends Equatable {
  final UserPreferencesModel userPrefernces;

  const UserPreferencesParams({required this.userPrefernces});

  @override
  List<Object?> get props => [userPrefernces];
}
