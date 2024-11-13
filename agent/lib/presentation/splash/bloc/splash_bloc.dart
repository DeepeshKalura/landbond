import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_auth/firebase_auth.dart';

@immutable
sealed class SplashEvent {}

final class TimerEndEvent extends SplashEvent {}

@immutable
sealed class SplashState {}

final class SplashScreenActiveState extends SplashState {}

final class LoggedInState extends SplashState {}

final class HomeScreenState extends SplashState {}

final class ErrorState extends SplashState {
  final String message;

  ErrorState(this.message);

  String get errorMessage => message;
}

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashScreenActiveState()) {
    on<TimerEndEvent>((event, emit) {
      if (FirebaseAuth.instance.currentUser == null) {
        log("User is not logged in");
        emit(LoggedInState());
      } else {
        emit(HomeScreenState());
      }
    });
  }
}
