part of 'user_data_bloc.dart';

abstract class UserDataEvent extends Equatable {
  const UserDataEvent();

  @override
  List<Object?> get props => [];
}

class UserDataLoad extends UserDataEvent {
  const UserDataLoad({this.completer});

  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}

class AddChangeUserData extends UserDataEvent {
  const AddChangeUserData({required this.userData});

  final UserDataModel userData;

  @override
  List<Object?> get props => [userData];
}

class GoogleAddUserData extends UserDataEvent {}
