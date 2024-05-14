import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../error/failures.dart';

abstract class GalleryControllerRepository {
  Future<Either<Failure, File>> getFromGallery(BuildContext context);
  Future<Either<Failure, Unit>> disposeGallery();
}
