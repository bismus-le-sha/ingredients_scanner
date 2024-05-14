import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter/material.dart';
import '../../../../error/exceptions.dart';
import '../../../../error/failures.dart';
import '../datasources/gallery_controller_data_source.dart';

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

  @override
  Future<Either<Failure, Unit>> disposeGallery() async {
    try {
      return Right(await galleryDataSource.disposeGallery());
    } on CameraException {
      return Left(CameraFailure());
    }
  }
}
