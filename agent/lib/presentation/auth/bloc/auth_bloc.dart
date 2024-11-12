import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
sealed class AuthEvent {}

@immutable
sealed class AuthState {}

final class AuthIntialState extends AuthState {}

//  Auth Event -  Auth State

final class LoginSignUpEvent extends AuthEvent {}

final class SignupState extends AuthState {}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthIntialState()) {
    on<LoginSignUpEvent>(_loginSignUp);
  }

  void _loginSignUp(LoginSignUpEvent event, Emitter<AuthState> emit) {
    emit(SignupState());
  }
}
