import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../../../helper/test_helper.mocks.dart';

import 'package:ingredients_scanner/core/util/gallery_controller/data/repositories/gallery_controller_repository_impl.dart';

void main() {
  late MockGalleryControllerDataSource dataSource;
  late GalleryControllerRepositoryImpl repositoryImpl;
  late MockBuildContext context;

  setUp(() => {
        dataSource = MockGalleryControllerDataSource(),
        context = MockBuildContext(),
        repositoryImpl =
            GalleryControllerRepositoryImpl(galleryDataSource: dataSource)
      });

  final testFile = File('');

  test('should get file from the gallery', () async {
    //arrange
    when(dataSource.getFromGallery(any)).thenAnswer((_) async => testFile);
    //act
    final result = await repositoryImpl.getFromGallery(context);
    //assert
    expect(result, Right(testFile));
    verify(dataSource.getFromGallery(context));
  });
}
