import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ingredients_scanner/core/error/failures.dart';
import 'package:ingredients_scanner/core/usecase/usecase.dart';
import 'package:ingredients_scanner/features/user_preferences/domain/entities/user_preferences_entity.dart';
import 'package:ingredients_scanner/features/user_preferences/domain/usecases/params/user_preferences_params.dart';
import 'package:ingredients_scanner/features/user_preferences/presentation/bloc/user_preferences_bloc.dart';
import 'package:mockito/mockito.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late UserPreferencesBloc bloc;
  late MockGetUserPreferences getUserPreferences;
  late MockUpdateCameraFlash updateCameraFlash;
  late MockUpdateUseBiometrics updateUseBiometrics;

  setUp(() {
    getUserPreferences = MockGetUserPreferences();
    updateCameraFlash = MockUpdateCameraFlash();
    updateUseBiometrics = MockUpdateUseBiometrics();

    bloc = UserPreferencesBloc(
        getUserPreferences: getUserPreferences,
        updateCameraFlash: updateCameraFlash,
        updateUseBiometrics: updateUseBiometrics);
  });

  test('initial State should be initial', () async {
    //assert
    expect(bloc.state, equals(UserPreferencesInitial()));
  });

  group('GetPreferences', () {
    const testPreferences =
        UserPreferencesEntity(cameraFlash: false, useBiometrics: true);

    blocTest<UserPreferencesBloc, UserPreferencesState>(
        'should get data from the get use case',
        build: () {
          when(getUserPreferences(any))
              .thenAnswer((_) async => const Right(testPreferences));
          return bloc..on<UserPreferencesLoad>((event, emit) {});
        },
        act: (bloc) => bloc.add(UserPreferencesLoad(completer: Completer())),
        wait: const Duration(milliseconds: 500),
        verify: (_) => verify(getUserPreferences(NoParams())).called(1));

    blocTest(
        'should emit [UserPreferencesLoaded] when data is gotten successfully',
        build: () {
          when(getUserPreferences(any))
              .thenAnswer((_) async => const Right(testPreferences));
          return bloc..on<UserPreferencesLoad>((event, emit) {});
        },
        act: (bloc) => bloc.add(UserPreferencesLoad(completer: Completer())),
        wait: const Duration(milliseconds: 500),
        expect: () =>
            [const UserPreferencesLoaded(userPreferences: testPreferences)]);

    blocTest(
      'should emit [UserPreferencesFailure] when data is get unsuccessfull',
      build: () {
        when(getUserPreferences(any))
            .thenAnswer((_) async => Left(DatabaseFailure()));
        return bloc..on<UserPreferencesLoad>((event, emit) {});
      },
      act: (bloc) => bloc.add(const UserPreferencesLoad()),
      wait: const Duration(milliseconds: 500),
      expect: () => [isA<UserPreferencesFailure>()],
    );
  });

  group('Update UserPreferences', () {
    const testPreferences =
        UserPreferencesEntity(cameraFlash: false, useBiometrics: true);
    const cameraFlash = true;
    const useBiometrics = false;

    blocTest('should update cameraFlash to the update camera flash usecase',
        build: () {
          when(updateCameraFlash(any))
              .thenAnswer((_) async => const Right(unit));
          return bloc..on<ChangeCameraFlash>((event, emit) {});
        },
        act: (bloc) => bloc.add(const ChangeCameraFlash(cameraFlash)),
        wait: const Duration(milliseconds: 500),
        verify: (_) => verify(updateCameraFlash(
                const UserPreferencesParams(value: cameraFlash)))
            .called(1));

    blocTest('should update useBiometrics to the update use biometrics usecase',
        build: () {
          when(updateUseBiometrics(any))
              .thenAnswer((_) async => const Right(unit));
          return bloc..on<ChangeUseBiometrics>((event, emit) {});
        },
        act: (bloc) => bloc.add(const ChangeUseBiometrics(useBiometrics)),
        wait: const Duration(milliseconds: 500),
        verify: (_) => verify(updateUseBiometrics(
                const UserPreferencesParams(value: useBiometrics)))
            .called(1));

    blocTest<UserPreferencesBloc, UserPreferencesState>(
      'should emit [UserPreferencesLoading, UserPreferencesLoaded] when ChangeCameraFlash event is added',
      build: () {
        when(updateCameraFlash(any)).thenAnswer((_) async => const Right(unit));
        when(getUserPreferences(any))
            .thenAnswer((_) async => const Right(testPreferences));
        return bloc..on<ChangeCameraFlash>((event, emit) {});
      },
      act: (bloc) => bloc.add(const ChangeCameraFlash(cameraFlash)),
      expect: () =>
          [isA<UserPreferencesLoading>(), isA<UserPreferencesLoaded>()],
    );

    blocTest<UserPreferencesBloc, UserPreferencesState>(
      'should emit [UserPreferencesLoading, UserPreferencesLoaded] when ChangeUseBiometrics event is added',
      build: () {
        when(updateUseBiometrics(any))
            .thenAnswer((_) async => const Right(unit));
        when(getUserPreferences(any))
            .thenAnswer((_) async => const Right(testPreferences));
        return bloc..on<ChangeUseBiometrics>((event, emit) {});
      },
      act: (bloc) => bloc.add(const ChangeUseBiometrics(useBiometrics)),
      expect: () =>
          [isA<UserPreferencesLoading>(), isA<UserPreferencesLoaded>()],
    );

    blocTest<UserPreferencesBloc, UserPreferencesState>(
      'should emit [UserPreferencesFailure] when update camera flash error occurs',
      build: () {
        when(updateCameraFlash(any))
            .thenAnswer((_) async => Left(DatabaseFailure()));
        return bloc..on<ChangeCameraFlash>((event, emit) {});
      },
      act: (bloc) => bloc.add(const ChangeCameraFlash(cameraFlash)),
      wait: const Duration(milliseconds: 500),
      expect: () => [isA<UserPreferencesFailure>()],
    );

    blocTest<UserPreferencesBloc, UserPreferencesState>(
      'should emit [UserPreferencesFailure] when update use biometrics error occurs',
      build: () {
        when(updateUseBiometrics(any))
            .thenAnswer((_) async => Left(DatabaseFailure()));
        return bloc..on<ChangeUseBiometrics>((event, emit) {});
      },
      act: (bloc) => bloc.add(const ChangeUseBiometrics(useBiometrics)),
      wait: const Duration(milliseconds: 500),
      expect: () => [isA<UserPreferencesFailure>()],
    );
  });
}
