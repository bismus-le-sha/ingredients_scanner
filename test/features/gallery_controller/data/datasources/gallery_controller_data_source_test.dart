import 'package:flutter/material.dart';
import 'package:gallery_picker/gallery_picker.dart';
import 'package:ingredients_scanner/core/util/gallery_controller/data/datasources/gallery_controller_data_source.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../../../helper/test_helper.mocks.dart';

//! Need to understand how to write static method tests

class GalleryPickerWrapper {
  Future<List<MediaFile>?> pickMedia(
      {required BuildContext context, required bool singleMedia}) {
    return GalleryPicker.pickMedia(context: context, singleMedia: singleMedia);
  }

  void dispose() {
    GalleryPicker.dispose();
  }
}

class MockGalleryPickerWrapper extends Mock implements GalleryPickerWrapper {}

void main() {
  late GalleryControllerDataSourceImpl dataSourceImpl;
  late MockBuildContext context;
  late MockGalleryPickerWrapper picker;

  setUp(() {
    dataSourceImpl = GalleryControllerDataSourceImpl();
    context = MockBuildContext();
    picker = MockGalleryPickerWrapper();
  });

  final MockMediaFile testFile = MockMediaFile();

  // test('should return File from gallery', () async {
  //   //arrange
  //   when(picker.pickMedia(context: context, singleMedia: true))
  //       .thenAnswer((_) => Future.value([testFile]));
  //   //act
  //   final result = await dataSourceImpl.getFromGallery(context);
  //   //assert
  //   verify(picker.pickMedia(context: context, singleMedia: true)).called(1);
  //   expect(result, testFile);
  // });

  // test('should return null from gallery', () async {
  //   //arrange
  //   when(picker.pickMedia(context: context, singleMedia: true))
  //       .thenAnswer((_) => Future.value(null));
  //   //act
  //   final result = await dataSourceImpl.getFromGallery(context);
  //   //assert
  //   verify(picker.pickMedia(context: context, singleMedia: true)).called(1);
  //   expect(result, null);
  // });

  // test('should dispose GalleryPicker', () async {
  //   //act
  //   dataSourceImpl.disposeGallery();
  //   //assert
  //   verify(picker.dispose()).called(1);
  // });
}
