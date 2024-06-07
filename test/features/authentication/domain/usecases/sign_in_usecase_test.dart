import 'package:dartz/dartz.dart';
import 'package:ingredients_scanner/features/authentication/domain/entities/sign_in_entity.dart';
import 'package:ingredients_scanner/features/authentication/domain/usecases/params/sign_in_params.dart';
import 'package:ingredients_scanner/features/authentication/domain/usecases/sign_in_usecase.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late SignInUseCase useCase;
  late MockAuthenticationRepository repository;

  setUp(() {
    repository = MockAuthenticationRepository();
    useCase = SignInUseCase(repository);
  });
  const testSignIn =
      SignInEntity(email: 'boby@gmail.com', password: 'password');
  final testCredential = MockUserCredential();

  test('should get user credential for the sing in user from the repository',
      () async {
    //arrange
    when(repository.signIn(testSignIn))
        .thenAnswer((_) async => Right(testCredential));
    //act
    final result = await useCase(const SignInParams(signInEntity: testSignIn));
    //assert
    expect(result, Right(testCredential));
    verify(repository.signIn(testSignIn));
    verifyNoMoreInteractions(repository);
  });
}
