import 'package:equatable/equatable.dart';

import '../../../data/models/user_preferences_model.dart';

class UserPreferencesParams extends Equatable {
  final UserPreferencesModel userPreferencesEntity;

  const UserPreferencesParams({required this.userPreferencesEntity});

  @override
  List<Object?> get props => [userPreferencesEntity];
}
