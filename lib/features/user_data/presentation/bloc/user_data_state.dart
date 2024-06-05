part of 'user_data_bloc.dart';

abstract class UserDataState extends Equatable {
  const UserDataState();

  @override
  List<Object?> get props => [];
}

class UserDataInitial extends UserDataState {}

class UserDataLoading extends UserDataState {}

class UserDataLoaded extends UserDataState {
  final UserDataEntity userData;

  const UserDataLoaded({required this.userData});

  @override
  List<Object?> get props => [userData];
}

class UserDataAddedUpdated extends UserDataState {}

class GoogleUserDataAdded extends UserDataState {}

class UserDataFailure extends UserDataState {
  final String message;

  const UserDataFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
