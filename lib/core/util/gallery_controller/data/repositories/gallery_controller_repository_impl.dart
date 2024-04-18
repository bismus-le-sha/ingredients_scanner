import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:flutter/material.dart';
import 'package:ingredients_scanner/core/error/exceptions.dart';
import 'package:ingredients_scanner/core/error/failures.dart';
import 'package:ingredients_scanner/core/util/gallery_controller/data/datasources/gallery_controller_data_source.dart';

import '../../domain/repositories/gallery_controller_repository.dart';

class GalleryControllerRepositoryImpl implements GalleryControllerRepository {
  final GalleryControllerDataSource galleryDataSource;

  GalleryControllerRepositoryImpl({required this.galleryDataSource});
  @override
  Future<Either<Failure, File>> getFromGallery(BuildContext context) async {
    try {
      return Right(await galleryDataSource.getFromGallery(context));
    } on NoSuchFileException {
      return Left(NoSuchFileFailure());
    }
  }
}
