import 'package:dartz/dartz.dart';
import 'package:ingredients_scanner/features/user_preferences/data/models/user_preferences_model.dart';
import 'package:ingredients_scanner/features/user_preferences/domain/usecases/params/user_preferences_params.dart';
import 'package:ingredients_scanner/features/user_preferences/domain/usecases/set_user_preferences.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late SetUserPreferences usecase;
  late MockUserPreferencesRepository mockUserPreferencesRepository;

  setUp(() {
    mockUserPreferencesRepository = MockUserPreferencesRepository();
    usecase = SetUserPreferences(mockUserPreferencesRepository);
  });

  const testUserPreferences =
      UserPreferencesModel(cameraFlash: false, useBiometrics: true);

  test('should set user preferences to the repository', () async {
    when(mockUserPreferencesRepository.setUserPreferences(testUserPreferences))
        .thenAnswer((_) async => const Right(unit));

    final result = await usecase(const UserPreferencesParams(
        userPreferencesEntity: testUserPreferences));

    expect(result, const Right(unit));
    verify(
        mockUserPreferencesRepository.setUserPreferences(testUserPreferences));
    verifyNoMoreInteractions(mockUserPreferencesRepository);
  });
}
