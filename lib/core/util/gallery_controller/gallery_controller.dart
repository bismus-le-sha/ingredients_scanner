import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:gallery_picker/gallery_picker.dart';
import 'package:ingredients_scanner/core/error/exceptions.dart';
import 'package:ingredients_scanner/core/error/failures.dart';

abstract class GalleryController {
  Future<Either<Failure, File>> getImage({required BuildContext context});
}

class GallerycontrollerImpl implements GalleryController {
  @override
  Future<Either<Failure, File>> getImage(
      {required BuildContext context}) async {
    try {
      List<MediaFile>? media =
          await GalleryPicker.pickMedia(context: context, singleMedia: true);
      if (media != null && media.isNotEmpty) {
        return Right(await media.first.getFile());
      } else {
        throw NoSuchFileException();
      }
    } on NoSuchFileException {
      return Left(NoSuchFileFailure());
    }
  }
}
