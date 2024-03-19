import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ingredients_scanner/core/error/exceptions.dart';
import 'package:ingredients_scanner/core/error/failures.dart';
import 'package:ingredients_scanner/features/authentication/data/models/sign_in_model.dart';
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
    group('sign_in test when device is online', () {
      setUp(() => when(networkInfo.isConnected).thenAnswer((_) async => true));
      body();
    });
  }

  group('signIn', () {
    final testUserCredential = MockUserCredential();
    const signInModel = SignInModel(
      email: 'boby@gmail.com',
      password: 'password',
    );

    test('should check if the device online', () async {
      // arrange
      when(networkInfo.isConnected).thenAnswer((_) async => true);
      when(remoteDataSource.signIn(signInModel))
          .thenAnswer((_) async => testUserCredential);
      // act
      final result = await repositoryImp.signIn(signInModel);
      // assert
      verify(networkInfo.isConnected);
      verify(remoteDataSource.signIn(signInModel));
      expect(result, Right(testUserCredential));
    });

    runTestOnline(() {
      group('sign_in test group', () {
        test('should return UserCredential when signIn is successful',
            () async {
          // arrange
          when(remoteDataSource.signIn(signInModel))
              .thenAnswer((_) async => testUserCredential);
          // act
          final result = await repositoryImp.signIn(signInModel);
          // assert
          verify(remoteDataSource.signIn(signInModel));
          expect(result, equals(Right(testUserCredential)));
        });

        test('should return ExistedAccountFailure when ExistedAccountException',
            () async {
          //arrange
          when(remoteDataSource.signIn(signInModel))
              .thenThrow(ExistedAccountException());
          //act
          final result = await repositoryImp.signIn(signInModel);
          //assert
          verify(remoteDataSource.signIn(signInModel));
          expect(result, equals(Left(ExistedAccountFailure())));
        });

        test('should return WrongPasswordFailure when WrongPasswordException',
            () async {
          //arrange
          when(remoteDataSource.signIn(signInModel))
              .thenThrow(WrongPasswordException());
          //act
          final result = await repositoryImp.signIn(signInModel);
          //assert
          verify(remoteDataSource.signIn(signInModel));
          expect(result, equals(Left(WrongPasswordFailure())));
        });

        test(
            'should return sign_in server failure when the call to firebase is unsuccessful',
            () async {
          //arrange
          when(remoteDataSource.signIn(signInModel))
              .thenThrow(ServerException());
          //act
          final result = await repositoryImp.signIn(signInModel);
          //assert
          verify(remoteDataSource.signIn(signInModel));
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
      final result = await repositoryImp.signIn(signInModel);
      //assert
      expect(result, equals(Left(OfflineFailure())));
    });
  });
}
