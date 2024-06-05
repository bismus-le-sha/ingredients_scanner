import 'package:dartz/dartz.dart';
import 'package:ingredients_scanner/features/user_preferences/data/models/user_preferences_model.dart';
import 'package:ingredients_scanner/features/user_preferences/domain/usecases/params/user_preferences_params.dart';
import 'package:ingredients_scanner/features/user_preferences/domain/usecases/update_user_preferences.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late UpdateUserPreferences usecase;
  late MockUserPreferencesRepository mockUserPreferencesRepository;
  late UserPreferencesModel testUserPreferencesModel;

  setUp(() {
    mockUserPreferencesRepository = MockUserPreferencesRepository();
    usecase = UpdateUserPreferences(mockUserPreferencesRepository);
    testUserPreferencesModel =
        const UserPreferencesModel(cameraFlash: true, useBiometrics: false);
  });

  test('should set cameraFlash value to the repository', () async {
    //arrange
    when(mockUserPreferencesRepository.updateUserPreferences(any))
        .thenAnswer((_) async => const Right(unit));
    //act
    final result = await usecase(
        UserPreferencesParams(userPreferences: testUserPreferencesModel));
    //assert
    expect(result, const Right(unit));
    verify(mockUserPreferencesRepository
        .updateUserPreferences(testUserPreferencesModel));
    verifyNoMoreInteractions(mockUserPreferencesRepository);
  });
}
