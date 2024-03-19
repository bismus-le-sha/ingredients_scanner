import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:ingredients_scanner/features/authentication/domain/usecases/check_verification_usecase.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late CheckVerificationUseCase useCase;
  late MockAuthenticationRepository repository;

  setUp(() {
    repository = MockAuthenticationRepository();
    useCase = CheckVerificationUseCase(repository);
  });

  final testCompleter = Completer();

  test('should returne complete for check_verification from repository',
      () async {
    //arrange
    when(repository.checkEmailVerification(testCompleter))
        .thenAnswer((_) async => const Right(unit));
    //act
    final result = await useCase(testCompleter);
    //assert
    expect(result, const Right(unit));
    verify(repository.checkEmailVerification(testCompleter));
    verifyNoMoreInteractions(repository);
  });
}
