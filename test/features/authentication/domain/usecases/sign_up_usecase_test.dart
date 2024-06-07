import 'package:dartz/dartz.dart';
import 'package:ingredients_scanner/features/authentication/domain/entities/sign_up_entity.dart';
import 'package:ingredients_scanner/features/authentication/domain/usecases/params/sign_up_params.dart';
import 'package:ingredients_scanner/features/authentication/domain/usecases/sign_up_usecase.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late SignUpUseCase useCase;
  late MockAuthenticationRepository repository;

  setUp(() {
    repository = MockAuthenticationRepository();
    useCase = SignUpUseCase(repository);
  });

  const testSignUp = SignUpEntity(
      name: 'bob',
      email: 'boby@gmail.com',
      password: 'password',
      repeatedPassword: 'password');
  final testCredential = MockUserCredential();

  test('should get user credential for the sing up user from the repository',
      () async {
    //arrange
    when(repository.signUp(testSignUp))
        .thenAnswer((_) async => Right(testCredential));
    //act
    final result = await useCase(const SignUpParams(signUpEntity: testSignUp));
    //assert
    expect(result, Right(testCredential));
    verify(repository.signUp(testSignUp));
    verifyNoMoreInteractions(repository);
  });
}
