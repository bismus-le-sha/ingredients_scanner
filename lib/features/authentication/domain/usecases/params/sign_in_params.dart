import 'package:equatable/equatable.dart';

import '../../entities/sign_in_entity.dart';

class SignInParams extends Equatable {
  final SignInEntity signInEntity;

  const SignInParams({required this.signInEntity});

  @override
  List<Object?> get props => [signInEntity];
}
