import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ingredients_scanner/features/authentication/domain/entities/sign_in_entity.dart';
import 'package:ingredients_scanner/features/authentication/domain/usecases/params/sign_in_params.dart';
import 'package:ingredients_scanner/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:mockito/mockito.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late AuthBloc bloc;
  late MockSignInUseCase signInUseCase;
  late MockSignUpUseCase signUpUseCase;
  late MockFirstPageUseCase firstPageUseCase;
  late MockVerifyEmailUseCase verifyEmailUseCase;
  late MockCheckVerificationUseCase checkVerificationUseCase;
  late MockGoogleAuthUseCase googleAuthUseCase;
  late MockLogOutUseCase logOutUseCase;

  setUp(() {
    signInUseCase = MockSignInUseCase();
    signUpUseCase = MockSignUpUseCase();
    firstPageUseCase = MockFirstPageUseCase();
    verifyEmailUseCase = MockVerifyEmailUseCase();
    checkVerificationUseCase = MockCheckVerificationUseCase();
    googleAuthUseCase = MockGoogleAuthUseCase();
    logOutUseCase = MockLogOutUseCase();

    bloc = AuthBloc(
        signInUseCase: signInUseCase,
        signUpUseCase: signUpUseCase,
        firstPageUseCase: firstPageUseCase,
        verifyEmailUseCase: verifyEmailUseCase,
        checkVerificationUseCase: checkVerificationUseCase,
        logOutUseCase: logOutUseCase,
        googleAuthUseCase: googleAuthUseCase);
  });

  test('initial State should be initial', () async {
    //assert
    expect(bloc.state, equals(AuthInitial()));
  });

  group('SignInUseCase', () {
    const testSignIn = SignInEntity(password: 'pass', email: 'test@gmail.com');
    final testUserCredential = MockUserCredential();

    blocTest<AuthBloc, AuthState>(
      'should get data from the get use case',
      build: () {
        when(signInUseCase(any))
            .thenAnswer((_) async => Right(testUserCredential));
        return bloc..on<SignInEvent>((event, emit) {});
      },
      act: (bloc) => bloc.add(SignInEvent(signInEntity: testSignIn)),
      wait: const Duration(milliseconds: 500),
      verify: (_) {
        verify(signInUseCase(const SignInParams(signInEntity: testSignIn)))
            .called(1);
      },
    );
  });
}
