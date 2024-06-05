import 'package:equatable/equatable.dart';
import '../../../data/models/user_preferences_model.dart';

class UserPreferencesParams extends Equatable {
  final UserPreferencesModel userPreferences;

  const UserPreferencesParams({required this.userPreferences});

  @override
  List<Object?> get props => [userPreferences];
}
