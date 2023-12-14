import 'package:flutter/material.dart';
import 'package:ingredients_scanner/models/user_params.dart';

abstract class AbstractUserParams {
  AbstractUserParams({
    required this.context,
    required this.userParams,
    required this.themeData,
  });

  final BuildContext context;
  final UserParams userParams;
  final ThemeData themeData;
}
