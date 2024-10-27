import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../service/database/shared_preferences_service.dart';
import '../../../service/firebase/authenticate_service.dart';

@immutable
sealed class SplashEvent {}

final class TimerEndEvent extends SplashEvent {}

@immutable
sealed class SplashState {}

final class SplashScreenActiveState extends SplashState {}

final class LoggedInState extends SplashState {}

final class HomeScreenState extends SplashState {}

final class OnbodingScreenState extends SplashState {}

final class ErrorState extends SplashState {
  final String message;

  ErrorState(this.message);

  String get errorMessage => message;
}

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final SharedPreferencesService _sharedPreferencesService;
  final AuthenticateService _authenticateService;
  SplashBloc(this._sharedPreferencesService, this._authenticateService)
      : super(SplashScreenActiveState()) {
    on<SplashEvent>(_onEvent);
  }

  Future<void> _onEvent(SplashEvent event, Emitter<SplashState> emit) async {
    emit(SplashScreenActiveState());

    try {
      final isNewUser = await _sharedPreferencesService.isNewUser();

      if (isNewUser) {
        emit(OnbodingScreenState());
      } else {
        final isAuthenticate = await _authenticateService.isAuthenticate();

        if (isAuthenticate) {
          emit(HomeScreenState());
        } else {
          emit(LoggedInState());
        }
      }
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
