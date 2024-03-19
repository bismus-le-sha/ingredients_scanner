import 'package:ingredients_scanner/features/authentication/domain/entities/first_page_entity.dart';
import 'package:ingredients_scanner/features/authentication/domain/usecases/first_page_usecase.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late FirstPageUseCase useCase;
  late MockAuthenticationRepository repository;

  setUp(() {
    repository = MockAuthenticationRepository();
    useCase = FirstPageUseCase(repository);
  });

  const testPage = FirstPageEntity(isLoggedIn: true, isVerifyingEmail: true);

  test('should return first page', () async {
    //arrange
    when(repository.firstPage()).thenAnswer((_) => testPage);
    //act
    final result = useCase();
    //assert
    expect(result, testPage);
    verify(repository.firstPage());
    verifyNoMoreInteractions(repository);
  });
}
