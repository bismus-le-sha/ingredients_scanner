import 'package:dartz/dartz.dart';
import 'package:ingredients_scanner/core/usecase/usecase.dart';
import 'package:ingredients_scanner/features/user_preferences/domain/entities/user_preferences_entity.dart';
import 'package:ingredients_scanner/features/user_preferences/domain/usecases/get_user_preference.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late GetUserPreferences usecase;
  late MockUserPreferencesRepository mockUserPreferencesRepository;

  setUp(() {
    mockUserPreferencesRepository = MockUserPreferencesRepository();
    usecase = GetUserPreferences(mockUserPreferencesRepository);
  });

  const testUserPreferences =
      UserPreferencesEntity(cameraFlash: false, useBiometrics: true);

  test('should get user preferences from the repository', () async {
    when(mockUserPreferencesRepository.getUserPreferences())
        .thenAnswer((_) async => const Right(testUserPreferences));

    final result = await usecase(NoParams());

    expect(result, const Right(testUserPreferences));
    verify(mockUserPreferencesRepository.getUserPreferences());
    verifyNoMoreInteractions(mockUserPreferencesRepository);
  });
}
