import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Event
@immutable
class AuthEvent {}

// State
@immutable
class AuthState {}

class EmailAuthLoadingState extends AuthState {}

class EmailAuthSuccessState extends AuthState {}

class EmailAuthFailureState extends AuthState {}

// Bloc Logic
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState());
}
