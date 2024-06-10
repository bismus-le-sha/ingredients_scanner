import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ingredients_scanner/features/authentication/domain/usecases/params/check_verification_params.dart';
import 'package:ingredients_scanner/features/authentication/domain/usecases/params/sign_in_params.dart';
import 'package:ingredients_scanner/features/authentication/domain/usecases/params/sign_up_params.dart';
import '../../../../core/usecase/usecase.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/resources/failures_list.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/sign_in_entity.dart';
import '../../domain/entities/sign_up_entity.dart';
import '../../domain/usecases/check_verification_usecase.dart';
import '../../domain/usecases/first_page_usecase.dart';
import '../../domain/usecases/google_auth_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';
import '../../domain/usecases/verifiy_email_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final VerifyEmailUseCase verifyEmailUseCase;
  final FirstPageUseCase firstPageUseCase;
  final CheckVerificationUseCase checkVerificationUseCase;
  final LogOutUseCase logOutUseCase;
  final GoogleAuthUseCase googleAuthUseCase;

  Completer<void> completer = Completer<void>();

  AuthBloc({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.firstPageUseCase,
    required this.verifyEmailUseCase,
    required this.checkVerificationUseCase,
    required this.logOutUseCase,
    required this.googleAuthUseCase,
  }) : super(AuthInitial()) {
    on<AuthEvent>(_mapEventToState);
  }

  Future<void> _mapEventToState(
      AuthEvent event, Emitter<AuthState> emit) async {
    if (event is CheckLoggingInEvent) {
      await _handleCheckLoggingInEvent(emit);
    } else if (event is SignInEvent) {
      await _handleSignInEvent(event, emit);
    } else if (event is SignUpEvent) {
      await _handleSignUpEvent(event, emit);
    } else if (event is SendEmailVerificationEvent) {
      await _handleSendEmailVerificationEvent(emit);
    } else if (event is CheckEmailVerificationEvent) {
      await _handleCheckEmailVerificationEvent(emit);
    } else if (event is LogOutEvent) {
      await _handleLogOutEvent(emit);
    } else if (event is SignInWithGoogleEvent) {
      await _handleSignInWithGoogleEvent(emit);
    }
  }

  Future<void> _handleCheckLoggingInEvent(Emitter<AuthState> emit) async {
    final failureOrFirstPage = await firstPageUseCase(NoParams());
    failureOrFirstPage.fold(
      (failure) => emit(ErrorAuthState(message: _mapFailureToMessage(failure))),
      (firstPage) {
        if (firstPage.isLoggedIn) {
          emit(SignedInPageState());
        } else if (firstPage.isVerifyingEmail) {
          emit(VerifyEmailPageState());
        }
      },
    );
  }

  Future<void> _handleSignInEvent(
      SignInEvent event, Emitter<AuthState> emit) async {
    emit(LoadingState());
    final failureOrUserCredential =
        await signInUseCase(SignInParams(signInEntity: event.signInEntity));
    emit(_eitherToState(failureOrUserCredential, SignedInState()));
  }

  Future<void> _handleSignUpEvent(
      SignUpEvent event, Emitter<AuthState> emit) async {
    emit(LoadingState());
    final failureOrUserCredential =
        await signUpUseCase(SignUpParams(signUpEntity: event.signUpEntity));
    emit(_eitherToState(failureOrUserCredential,
        SignedUpState(signUpEntity: event.signUpEntity)));
  }

  Future<void> _handleSendEmailVerificationEvent(
      Emitter<AuthState> emit) async {
    final failureOrSentEmail = await verifyEmailUseCase(NoParams());
    emit(_eitherToState(failureOrSentEmail, EmailIsSentState()));
  }

  Future<void> _handleCheckEmailVerificationEvent(
      Emitter<AuthState> emit) async {
    if (!completer.isCompleted) {
      completer.complete();
      completer = Completer<void>();
    }
    final failureOrEmailVerified = await checkVerificationUseCase(
        CheckVerificationParams(completer: completer));
    emit(_eitherToState(failureOrEmailVerified, EmailIsVerifiedState()));
  }

  Future<void> _handleLogOutEvent(Emitter<AuthState> emit) async {
    final failureOrLogOut = await logOutUseCase(NoParams());
    emit(_eitherToState(failureOrLogOut, LoggedOutState()));
  }

  Future<void> _handleSignInWithGoogleEvent(Emitter<AuthState> emit) async {
    emit(LoadingState());
    final failureOrUserCredential = await googleAuthUseCase(NoParams());
    emit(_eitherToState(failureOrUserCredential, GoogleSignInState()));
  }

  AuthState _eitherToState(Either<Failure, dynamic> either, AuthState state) {
    return either.fold(
      (failure) => ErrorAuthState(message: _mapFailureToMessage(failure)),
      (_) => state,
    );
  }

  String _mapFailureToMessage(Failure failure) {
    const failureMessages = {
      ServerFailure: SERVER_FAILURE_MESSAGE,
      OfflineFailure: OFFLINE_FAILURE_MESSAGE,
      WeekPassFailure: WEEK_PASS_FAILURE_MESSAGE,
      ExistedAccountFailure: EXISTED_ACCOUNT_FAILURE_MESSAGE,
      NoUserFailure: NO_USER_FAILURE_MESSAGE,
      TooManyRequestsFailure: TOO_MANY_REQUESTS_FAILURE_MESSAGE,
      WrongPasswordFailure: WRONG_PASSWORD_FAILURE_MESSAGE,
      UnmatchedPassFailure: UNMATCHED_PASSWORD_FAILURE_MESSAGE,
      NotLoggedInFailure: '',
    };

    return failureMessages[failure.runtimeType] ??
        "Unexpected Error, Please try again later.";
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    sl<Talker>().handle(error, stackTrace);
  }
}
