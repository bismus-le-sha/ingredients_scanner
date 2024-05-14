import 'package:dartz/dartz.dart';
import '../../../../error/failures.dart';
import '../../../../usecase/usecase.dart';
import '../repositories/gallery_controller_repository.dart';

class DisposeGallery extends UseCase<Unit, NoParams> {
  final GalleryControllerRepository galleryRepository;

  DisposeGallery(this.galleryRepository);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) {
    return galleryRepository.disposeGallery();
  }
}
