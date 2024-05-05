import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/usecase/usecase.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/constants/failures.dart';
import '../../../../../injection_container.dart';
import '../../../domain/entities/sign_in_entity.dart';
import '../../../domain/entities/sign_up_entity.dart';
import '../../../domain/usecases/check_verification_usecase.dart';
import '../../../domain/usecases/first_page_usecase.dart';
import '../../../domain/usecases/google_auth_usecase.dart';
import '../../../domain/usecases/logout_usecase.dart';
import '../../../domain/usecases/sign_in_usecase.dart';
import '../../../domain/usecases/sign_up_usecase.dart';
import '../../../domain/usecases/verifiy_email_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final VerifyEmailUseCase verifyEmailUseCase;
  final FirstPageUseCase firstPage;
  final CheckVerificationUseCase checkVerificationUseCase;
  final LogOutUseCase logOutUseCase;
  final GoogleAuthUseCase googleAuthUseCase;

  Completer<void> completer = Completer<void>();

  AuthBloc(
      {required this.signInUseCase,
      required this.signUpUseCase,
      required this.firstPage,
      required this.verifyEmailUseCase,
      required this.checkVerificationUseCase,
      required this.logOutUseCase,
      required this.googleAuthUseCase})
      : super(AuthInitial()) {
    on<AuthEvent>((event, emit) => _authMapEventToState(event, emit));
  }

  Future<void> _authMapEventToState(
      AuthEvent event, Emitter<AuthState> emit) async {
    if (event is CheckLoggingInEvent) {
      final theFirstPage = firstPage();
      if (theFirstPage.isLoggedIn) {
        emit(SignedInPageState());
      } else if (theFirstPage.isVerifyingEmail) {
        emit(VerifyEmailPageState());
      }
    } else if (event is SignInEvent) {
      emit(LoadingState());
      final failureOrUserCredential = await signInUseCase(event.signInEntity);
      emit(_eitherToState(failureOrUserCredential, SignedInState()));
    } else if (event is SignUpEvent) {
      emit(LoadingState());
      final failureOrUserCredential = await signUpUseCase(event.signUpEntity);
      emit(_eitherToState(failureOrUserCredential, SignedUpState()));
    } else if (event is SendEmailVerificationEvent) {
      final failureOrSentEmail = await verifyEmailUseCase(NoParams());
      emit(_eitherToState(failureOrSentEmail, EmailIsSentState()));
    } else if (event is CheckEmailVerificationEvent) {
      if (!completer.isCompleted) {
        completer.complete();
        completer = Completer<void>();
      }
      final failureOrEmailVerified = await checkVerificationUseCase(completer);
      emit(_eitherToState(failureOrEmailVerified, EmailIsVerifiedState()));
    } else if (event is LogOutEvent) {
      final failureOrLogOut = await logOutUseCase(NoParams());
      emit(_eitherToState(failureOrLogOut, LoggedOutState()));
    } else if (event is SignInWithGoogleEvent) {
      emit(LoadingState());
      final failureOrUserCredential = await googleAuthUseCase(NoParams());
      emit(_eitherToState(failureOrUserCredential, GoogleSignInState()));
    }
  }

  AuthState _eitherToState(Either either, AuthState state) {
    return either.fold(
      (failure) => ErrorAuthState(message: _mapFailureToMessage(failure)),
      (_) => state,
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case const (ServerFailure):
        return SERVER_FAILURE_MESSAGE;
      case const (OfflineFailure):
        return OFFLINE_FAILURE_MESSAGE;
      case const (WeekPassFailure):
        return WEEK_PASS_FAILURE_MESSAGE;
      case const (ExistedAccountFailure):
        return EXISTED_ACCOUNT_FAILURE_MESSAGE;
      case const (NoUserFailure):
        return NO_USER_FAILURE_MESSAGE;
      case const (TooManyRequestsFailure):
        return TOO_MANY_REQUESTS_FAILURE_MESSAGE;
      case const (WrongPasswordFailure):
        return WRONG_PASSWORD_FAILURE_MESSAGE;
      case const (UnmatchedPassFailure):
        return UNMATCHED_PASSWORD_FAILURE_MESSAGE;
      case const (NotLoggedInFailure):
        return '';
      default:
        return "Unexpected Error , Please try again later .";
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    sl<Talker>().handle(error, stackTrace);
  }
}
