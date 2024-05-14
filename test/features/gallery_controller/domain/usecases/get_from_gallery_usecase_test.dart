import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ingredients_scanner/core/util/gallery_controller/domain/usecases/get_from_gallery.dart';
import 'package:ingredients_scanner/core/util/gallery_controller/domain/usecases/params/gallery_controller_params.dart';
import 'package:mockito/mockito.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late GetFromGallery usecase;
  late MockGalleryControllerRepository repository;
  late MockBuildContext context;

  setUp(() => {
        repository = MockGalleryControllerRepository(),
        context = MockBuildContext(),
        usecase = GetFromGallery(repository)
      });

  final testFile = File('');

  test('should get file from the repository', () async {
    //arrange
    when(repository.getFromGallery(context))
        .thenAnswer((_) async => Right(testFile));
    //act
    final result =
        await usecase.call(GalleryControllerParams(context: context));
    //assert
    expect(result, Right(testFile));
  });
}
