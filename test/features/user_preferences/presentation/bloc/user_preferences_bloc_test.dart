import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ingredients_scanner/core/error/failures.dart';
import 'package:ingredients_scanner/core/usecase/usecase.dart';
import 'package:ingredients_scanner/features/user_preferences/data/models/user_preferences_model.dart';
import 'package:ingredients_scanner/features/user_preferences/domain/entities/user_preferences_entity.dart';
import 'package:ingredients_scanner/features/user_preferences/domain/usecases/params/user_preferences_params.dart';
import 'package:ingredients_scanner/features/user_preferences/presentation/bloc/user_preferences_bloc.dart';
import 'package:mockito/mockito.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late UserPreferencesBloc bloc;
  late MockGetUserPreferences getUserPreferences;
  late MockUpdateUserPreferences updateUserPreferences;
  late UserPreferencesEntity testPreferences;
  late UserPreferencesModel testUserPreferencesModel;

  setUp(() {
    getUserPreferences = MockGetUserPreferences();
    updateUserPreferences = MockUpdateUserPreferences();
    testPreferences =
        const UserPreferencesEntity(cameraFlash: false, useBiometrics: true);

    bloc = UserPreferencesBloc(
        getUserPreferences: getUserPreferences,
        updateUserPreferences: updateUserPreferences);
    testUserPreferencesModel =
        const UserPreferencesModel(cameraFlash: true, useBiometrics: false);
  });

  test('initial State should be initial', () async {
    //assert
    expect(bloc.state, equals(UserPreferencesInitial()));
  });

  group('GetPreferences', () {
    blocTest<UserPreferencesBloc, UserPreferencesState>(
        'should get data from the get use case',
        build: () {
          when(getUserPreferences(any))
              .thenAnswer((_) async => Right(testPreferences));
          return bloc..on<UserPreferencesLoad>((event, emit) {});
        },
        act: (bloc) => bloc.add(UserPreferencesLoad(completer: Completer())),
        wait: const Duration(milliseconds: 500),
        verify: (_) => verify(getUserPreferences(NoParams())).called(1));

    blocTest(
        'should emit [UserPreferencesLoaded] when data is gotten successfully',
        build: () {
          when(getUserPreferences(any))
              .thenAnswer((_) async => Right(testPreferences));
          return bloc..on<UserPreferencesLoad>((event, emit) {});
        },
        act: (bloc) => bloc.add(UserPreferencesLoad(completer: Completer())),
        wait: const Duration(milliseconds: 500),
        expect: () =>
            [UserPreferencesLoaded(userPreferences: testPreferences)]);

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
    blocTest(
        'should update user preferences to the update user preferences usecase',
        build: () {
          when(updateUserPreferences(any))
              .thenAnswer((_) async => const Right(unit));
          return bloc..on<ChangeUserPreferences>((event, emit) {});
        },
        act: (bloc) =>
            bloc.add(ChangeUserPreferences(testUserPreferencesModel)),
        wait: const Duration(milliseconds: 500),
        verify: (_) => verify(updateUserPreferences(UserPreferencesParams(
                userPrefernces: testUserPreferencesModel)))
            .called(1));

    blocTest<UserPreferencesBloc, UserPreferencesState>(
      'should emit [UserPreferencesLoading, UserPreferencesLoaded] when ChangeUserPreferences event is added',
      build: () {
        when(updateUserPreferences(any))
            .thenAnswer((_) async => const Right(unit));
        when(getUserPreferences(any))
            .thenAnswer((_) async => Right(testPreferences));
        return bloc..on<ChangeUserPreferences>((event, emit) {});
      },
      act: (bloc) => bloc.add(ChangeUserPreferences(testUserPreferencesModel)),
      expect: () =>
          [isA<UserPreferencesLoading>(), isA<UserPreferencesLoaded>()],
    );

    blocTest<UserPreferencesBloc, UserPreferencesState>(
      'should emit [UserPreferencesFailure] when update user preferences error occurs',
      build: () {
        when(updateUserPreferences(any))
            .thenAnswer((_) async => Left(DatabaseFailure()));
        return bloc..on<ChangeUserPreferences>((event, emit) {});
      },
      act: (bloc) => bloc.add(ChangeUserPreferences(testUserPreferencesModel)),
      wait: const Duration(milliseconds: 500),
      expect: () => [isA<UserPreferencesFailure>()],
    );
  });
}
