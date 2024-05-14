import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../error/failures.dart';
import '../../../../usecase/usecase.dart';
import '../repositories/gallery_controller_repository.dart';
import 'params/gallery_controller_params.dart';

class GetFromGallery extends UseCase<File, GalleryControllerParams> {
  final GalleryControllerRepository galleryRepository;

  GetFromGallery(this.galleryRepository);

  @override
  Future<Either<Failure, File>> call(GalleryControllerParams params) {
    return galleryRepository.getFromGallery(params.context);
  }
}
