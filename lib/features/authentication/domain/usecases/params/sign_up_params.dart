import 'package:equatable/equatable.dart';

import '../../entities/sign_up_entity.dart';

class SignUpParams extends Equatable {
  final SignUpEntity signUpEntity;

  const SignUpParams({required this.signUpEntity});

  @override
  List<Object?> get props => [signUpEntity];
}
