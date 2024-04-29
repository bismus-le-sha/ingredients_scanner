import 'package:equatable/equatable.dart';

part 'auth/failures_auth.dart';
part 'food_preferences/failures_user_preferences.dart';
part 'util/gallery_controller/failure_galery_controller.dart';
part 'util/camera_controller/failure_camera_controller.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]);

  @override
  List<Object> get props => [];
}

class OfflineFailure extends Failure {}

class ServerFailure extends Failure {}

class DatabaseFailure extends Failure {}
