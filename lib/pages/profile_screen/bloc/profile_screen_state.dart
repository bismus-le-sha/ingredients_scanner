part of 'profile_screen_bloc.dart';

sealed class ProfileScreenState extends Equatable {
  const ProfileScreenState();
  
  @override
  List<Object> get props => [];
}

final class ProfileScreenInitial extends ProfileScreenState {}
