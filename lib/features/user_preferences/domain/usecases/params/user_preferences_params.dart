import 'package:equatable/equatable.dart';

class UserPreferencesParams extends Equatable {
  final bool value;

  const UserPreferencesParams({required this.value});

  @override
  List<Object?> get props => [value];
}
