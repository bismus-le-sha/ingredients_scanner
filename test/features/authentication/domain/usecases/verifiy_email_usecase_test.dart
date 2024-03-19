import 'package:dartz/dartz.dart';
import 'package:ingredients_scanner/core/usecase/usecase.dart';
import 'package:ingredients_scanner/features/authentication/domain/usecases/verifiy_email_usecase.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late VerifyEmailUseCase useCase;
  late MockAuthenticationRepository repository;

  setUp(() {
    repository = MockAuthenticationRepository();
    useCase = VerifyEmailUseCase(repository);
  });

  test('should get succces for verify_email from repository', () async {
    //arrange
    when(repository.verifyEmail()).thenAnswer((_) async => const Right(unit));
    //act
    final result = await useCase(NoParams());
    //assert
    expect(result, const Right(unit));
    verify(repository.verifyEmail());
    verifyNoMoreInteractions(repository);
  });
}
