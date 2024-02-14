import 'package:flutter/material.dart';

abstract interface class UserPreferencesItem {
  Iterable<String> get labels;
  Widget Function(BuildContext) get builder;
}

class UserPreferencesItemImpl implements UserPreferencesItem {
  const UserPreferencesItemImpl({
    required this.labels,
    required this.builder,
  });

  @override
  final Iterable<String> labels;

  @override
  final Widget Function(BuildContext) builder;
}
