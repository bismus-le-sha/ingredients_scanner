import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class GalleryControllerParams extends Equatable {
  final BuildContext context;

  const GalleryControllerParams({required this.context});

  @override
  List<Object?> get props => [context];
}
