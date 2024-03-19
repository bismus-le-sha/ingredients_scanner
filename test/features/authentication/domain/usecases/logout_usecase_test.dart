import 'package:dartz/dartz.dart';
import 'package:ingredients_scanner/core/usecase/usecase.dart';
import 'package:ingredients_scanner/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late LogOutUseCase useCase;
  late MockAuthenticationRepository repository;

  setUp(() {
    repository = MockAuthenticationRepository();
    useCase = LogOutUseCase(repository);
  });

  test('should get succes for logout from repository', () async {
    //arrange
    when(repository.logOut()).thenAnswer((_) async => const Right(unit));
    //act
    final result = await useCase(NoParams());
    //assert
    expect(result, const Right(unit));
    verify(repository.logOut());
    verifyNoMoreInteractions(repository);
  });
}
