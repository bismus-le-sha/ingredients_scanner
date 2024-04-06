import 'package:dartz/dartz.dart';
import 'package:ingredients_scanner/features/user_preferences/domain/usecases/params/user_preferences_params.dart';
import 'package:ingredients_scanner/features/user_preferences/domain/usecases/update_use_biometrics.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late UpdateUseBiometrics usecase;
  late MockUserPreferencesRepository mockUserPreferencesRepository;

  setUp(() {
    mockUserPreferencesRepository = MockUserPreferencesRepository();
    usecase = UpdateUseBiometrics(mockUserPreferencesRepository);
  });

  const bool testValue = true;

  test('should set useBiometrics value to the repository', () async {
    //arrange
    when(mockUserPreferencesRepository.updateUseBiometrics(any))
        .thenAnswer((_) async => const Right(unit));
    //act
    final result = await usecase(const UserPreferencesParams(value: testValue));
    //assert
    expect(result, const Right(unit));
    verify(mockUserPreferencesRepository.updateUseBiometrics(testValue));
    verifyNoMoreInteractions(mockUserPreferencesRepository);
  });
}
