import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ingredients_scanner/core/error/failures.dart';
import 'package:ingredients_scanner/core/usecase/usecase.dart';
import 'package:ingredients_scanner/core/util/gallery_controller/domain/repositories/gallery_controller_repository.dart';
import 'package:ingredients_scanner/core/util/gallery_controller/domain/usecases/params/gallery_controller_params.dart';

class GetFromGallery extends UseCase<File, GalleryControllerParams> {
  final GalleryControllerRepository galleryRepository;

  GetFromGallery(this.galleryRepository);

  @override
  Future<Either<Failure, File>> call(GalleryControllerParams params) {
    return galleryRepository.getFromGallery(params.context);
  }
}
