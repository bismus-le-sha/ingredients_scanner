import 'package:dartz/dartz.dart';
import 'package:ingredients_scanner/core/usecase/usecase.dart';
import 'package:ingredients_scanner/features/authentication/domain/usecases/google_auth_usecase.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late GoogleAuthUseCase useCase;
  late MockAuthenticationRepository repository;

  setUp(() {
    repository = MockAuthenticationRepository();
    useCase = GoogleAuthUseCase(repository);
  });

  final testCredential = MockUserCredential();

  test(
      'should get user credential for the google sign in user from the repository',
      () async {
    //arrange
    when(repository.googleSignIn())
        .thenAnswer((_) async => Right(testCredential));
    //act
    final result = await useCase(NoParams());
    //assert
    expect(result, Right(testCredential));
    verify(repository.googleSignIn());
    verifyNoMoreInteractions(repository);
  });
}
