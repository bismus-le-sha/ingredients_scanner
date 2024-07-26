import 'package:equatable/equatable.dart';

class UserDataEntity extends Equatable {
  final String userName;
  final String email;
  final String? avatar;

  const UserDataEntity({
    required this.userName,
    required this.email,
    required this.avatar,
  });

  @override
  List<Object?> get props => [
        userName,
        email,
        avatar,
      ];
}
