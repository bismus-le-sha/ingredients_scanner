import 'dart:async';

import 'package:equatable/equatable.dart';

class CheckVerificationParams extends Equatable {
  final Completer completer;

  const CheckVerificationParams({required this.completer});

  @override
  List<Object?> get props => [completer];
}
