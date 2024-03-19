import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ingredients_scanner/core/error/exceptions.dart';
import 'package:ingredients_scanner/core/error/failures.dart';
import 'package:ingredients_scanner/features/authentication/data/models/sign_up_model.dart';
import 'package:ingredients_scanner/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:mockito/mockito.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late AuthenticationRepositoryImp repositoryImp;
  late MockAuthRemoteDataSource remoteDataSource;
  late MockNetworkInfo networkInfo;

  setUp(() {
    remoteDataSource = MockAuthRemoteDataSource();
    networkInfo = MockNetworkInfo();
    repositoryImp = AuthenticationRepositoryImp(
        authRemoteDataSource: remoteDataSource, networkInfo: networkInfo);
  });

  void runTestOnline(Function body) {
    group('sign_up test when device is online', () {
      setUp(() => when(networkInfo.isConnected).thenAnswer((_) async => true));
      body();
    });
  }

  group('sign_up', () {
    const signUpModel = SignUpModel(
        name: 'boby',
        email: 'boby@gmail.com',
        password: 'password',
        repeatedPassword: 'password');

    final testUserCredential = MockUserCredential();

    test('should check if the device online', () async {
      //arrange
      when(networkInfo.isConnected).thenAnswer((_) async => true);
      when(remoteDataSource.signUp(signUpModel))
          .thenAnswer((_) async => testUserCredential);
      //act
      final result = await repositoryImp.signUp(signUpModel);
      //assert
      verify(networkInfo.isConnected);
      verify(remoteDataSource.signUp(signUpModel));
      expect(result, equals(Right(testUserCredential)));
    });

    runTestOnline(() {
      group('sign_up test group', () {
        test('should return UserCredential when signUp is successful',
            () async {
          // arrange
          when(remoteDataSource.signUp(signUpModel))
              .thenAnswer((_) async => testUserCredential);
          // act
          final result = await repositoryImp.signUp(signUpModel);
          // assert
          verify(remoteDataSource.signUp(signUpModel));
          expect(result, equals(Right(testUserCredential)));
        });

//TODO: test for UnmatchedPassFailure()

        test('should return ExistedAccountFailure when ExistedAccountException',
            () async {
          //arrange
          when(remoteDataSource.signUp(signUpModel))
              .thenThrow(ExistedAccountException());
          //act
          final result = await repositoryImp.signUp(signUpModel);
          //assert
          verify(remoteDataSource.signUp(signUpModel));
          expect(result, equals(Left(ExistedAccountFailure())));
        });

        test('should return WrongPasswordFailure when WrongPasswordException',
            () async {
          //arrange
          when(remoteDataSource.signUp(signUpModel))
              .thenThrow(WeekPassException());
          //act
          final result = await repositoryImp.signUp(signUpModel);
          //assert
          verify(remoteDataSource.signUp(signUpModel));
          expect(result, equals(Left(WeekPassFailure())));
        });

        test(
            'should return sign_up server failure when the call to firebase is unsuccessful',
            () async {
          //arrange
          when(remoteDataSource.signUp(signUpModel))
              .thenThrow(ServerException());
          //act
          final result = await repositoryImp.signUp(signUpModel);
          //assert
          verify(remoteDataSource.signUp(signUpModel));
          expect(result, equals(Left(ServerFailure())));
        });
      });
    });

    test(
        'should return OfflineFailure when the call to firebase is unsuccessful',
        () async {
      //arrange
      when(networkInfo.isConnected).thenAnswer((_) async => false);
      //act
      final result = await repositoryImp.signUp(signUpModel);
      //assert
      expect(result, equals(Left(OfflineFailure())));
    });
  });
}
