part of 'hello_screen_bloc.dart';

sealed class HelloScreenState extends Equatable {
  const HelloScreenState();
  
  @override
  List<Object> get props => [];
}

final class HelloScreenInitial extends HelloScreenState {}
