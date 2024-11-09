import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../service/files/image_picker_service.dart';
import '../../../service/firebase/authenticate_service.dart';
import "package:landbond/locator/injector.dart" as di;

part 'client_signup_event_state.dart';

/*
 Auth bloc is responsible for handling authentication flow for this application

 Due to too much state and event, it will be split into many in which we will have event and there stage ok

*/

// Event
@immutable
sealed class AuthEvent {}

final class SigninButtonPressedEvent extends AuthEvent {}

final class GuestButtonPressedEvent extends AuthEvent {}

final class GoogleSignInButtonPressedEvent extends AuthEvent {}

final class AppleSignInButtonPressedEvent extends AuthEvent {}

final class FacebookSignInButtonPressedEvent extends AuthEvent {}

final class TogglePasswordButtonPressedEvent extends AuthEvent {
  final bool isPasswordVisible;

  TogglePasswordButtonPressedEvent(this.isPasswordVisible);
}

final class ToggleConfirmPasswordButtonPressedEvent extends AuthEvent {
  final bool isPasswordVisible;

  ToggleConfirmPasswordButtonPressedEvent(this.isPasswordVisible);
}

final class ForgotPasswordButtonPressedEvent extends AuthEvent {}

final class LoginButtonPressedEvent extends AuthEvent {}

final class EmailAuthEvent extends AuthEvent {
  final String email;
  final String password;

  EmailAuthEvent(this.email, this.password);
}

class ResetPasswordButtonPressed extends AuthEvent {
  final String email;

  ResetPasswordButtonPressed(this.email);
}

class VerifyCodeButtonPressed extends AuthEvent {
  final String email;
  final String code;

  VerifyCodeButtonPressed(this.email, this.code);
}

class ConfirmResetPasswordButtonPressed extends AuthEvent {}

class UpdatePasswordButtonPressed extends AuthEvent {
  final String password;

  UpdatePasswordButtonPressed(this.password);
}

class SignupButtonPressedEvent extends AuthEvent {}

// State
@immutable
sealed class AuthState {}

class EmailAuthSuccessState extends AuthState {}

class SignupNextScreenState extends AuthState {}

class SigninNextScreenState extends AuthState {}

class GuestAuthSuccessState extends AuthState {}

class PasswordVissibelState extends AuthState {}

class PasswordInvissibelState extends AuthState {}

class ConfirmPasswordVissibelState extends AuthState {}

class ConfirmPasswordInvissibelState extends AuthState {}

class ForgotPasswordButtonState extends AuthState {}

class EmailAuthLoadingState extends AuthState {}

class IntitalAuthState extends AuthState {}

class EmailAuthFailureState extends AuthState {
  final String message;

  EmailAuthFailureState(this.message);

  String get errorMessage => message;
}

class VerifyEmailState extends AuthState {}

class GoogleAuthLoadingState extends AuthState {}

class GoogleAuthSuccessState extends AuthState {}

class GoogleAuthFailureState extends AuthState {}

class AppleAuthLoadingState extends AuthState {}

class AppleAuthSuccessState extends AuthState {}

class AppleAuthFailureState extends AuthState {}

class ConfirmForgotPasswordState extends AuthState {}

class NewPasswordState extends AuthState {}

class UpdatePasswordState extends AuthState {}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  XFile? image;

  final _auth = di.injector<FirebaseService>();

  AuthBloc() : super(IntitalAuthState()) {
    on<SignupButtonPressedEvent>(_signupScreen);

    on<SigninButtonPressedEvent>(_signin);

    on<GuestButtonPressedEvent>(_guest);

    on<TogglePasswordButtonPressedEvent>(_togglePassword);

    on<ForgotPasswordButtonPressedEvent>(_forgotPassword);

    on<EmailAuthEvent>(_emailSignIn);

    on<ResetPasswordButtonPressed>(_verifyEmail);

    on<VerifyCodeButtonPressed>(_confirmForgotPassword);

    on<ConfirmResetPasswordButtonPressed>(_emailHasVerfied);

    on<ToggleConfirmPasswordButtonPressedEvent>(_toggleConfirmPassword);

    on<UpdatePasswordButtonPressed>(_updatePassword);

    // Client Signup Bloc

    on<ImagePickerButtonPressedEvent>(_pickingImage);

    on<ClinetSignupButtonPressedEvent>(_signup);
  }

  void _signupScreen(SignupButtonPressedEvent event, Emitter<AuthState> emit) {
    emit(SignupNextScreenState());
  }

  Future<void> _signup(
      ClinetSignupButtonPressedEvent event, Emitter<AuthState> emit) async {
    emit(ClientSignupLoadingState());

    try {
      final File profilePhoto = File(event.profilePhoto.path);

      await _auth.createUserWithEmail(
          event.email, event.password, event.name, profilePhoto);

      emit(ClientSignupSuccessState());
    } catch (e) {
      emit(ClientSignupFailureState(e.toString()));
    }
  }

  void _pickingImage(
      ImagePickerButtonPressedEvent event, Emitter<AuthState> emit) async {
    emit(ImagePickerLoadingState());

    try {
      image = await di.injector<ImagePickerService>().pickImage();

      emit(ImagePickerSuccessState(image!));
    } catch (e) {
      emit(ImagePickerFailureState(e.toString()));
    }
  }

  void _updatePassword(
      UpdatePasswordButtonPressed event, Emitter<AuthState> emit) {
    emit(UpdatePasswordState());
  }

  void _toggleConfirmPassword(
      ToggleConfirmPasswordButtonPressedEvent event, Emitter<AuthState> emit) {
    if (event.isPasswordVisible) {
      emit(ConfirmPasswordVissibelState());
    } else {
      emit(ConfirmPasswordInvissibelState());
    }
  }

  void _emailHasVerfied(
      ConfirmResetPasswordButtonPressed event, Emitter<AuthState> emit) {
    emit(NewPasswordState());
  }

  void _verifyEmail(ResetPasswordButtonPressed event, Emitter<AuthState> emit) {
    emit(VerifyEmailState());
  }

  void _confirmForgotPassword(
      VerifyCodeButtonPressed event, Emitter<AuthState> emit) {
    emit(ConfirmForgotPasswordState());
  }

  void _forgotPassword(
      ForgotPasswordButtonPressedEvent event, Emitter<AuthState> emit) {
    emit(ForgotPasswordButtonState());
  }

  void _togglePassword(
      TogglePasswordButtonPressedEvent event, Emitter<AuthState> emit) {
    if (event.isPasswordVisible) {
      emit(PasswordVissibelState());
    } else {
      emit(PasswordInvissibelState());
    }
  }

  void _signin(SigninButtonPressedEvent event, Emitter<AuthState> emit) {
    emit((SigninNextScreenState()));
  }

  void _guest(GuestButtonPressedEvent event, Emitter<AuthState> emit) {
    emit(GuestAuthSuccessState());
  }

  Future<void> _emailSignIn(
      EmailAuthEvent event, Emitter<AuthState> emit) async {
    emit(EmailAuthLoadingState());

    try {
      final auth = FirebaseService();

      await auth.signInWithEmail(event.email, event.password);

      if (await auth.isAuthenticate()) {
        emit(EmailAuthSuccessState());
      } else {
        emit(EmailAuthFailureState("Frontend Mobile developer error"));
      }
    } catch (e) {
      emit(EmailAuthFailureState(e.toString()));
    }
  }
}
