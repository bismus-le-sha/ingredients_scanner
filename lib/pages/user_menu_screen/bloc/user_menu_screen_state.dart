part of 'user_menu_screen_bloc.dart';

sealed class UserMenuScreenState extends Equatable {
  const UserMenuScreenState();
  
  @override
  List<Object> get props => [];
}

final class UserMenuScreenInitial extends UserMenuScreenState {}
