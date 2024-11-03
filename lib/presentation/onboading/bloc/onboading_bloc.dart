import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../service/timer/timer_service.dart';

// Events for OnboardingBloc
@immutable
sealed class OnboardingEvent {}

class StartOnboardingEvent extends OnboardingEvent {}

class SkipOnboardingEvent extends OnboardingEvent {}

class StartNextOnboardingEvent extends OnboardingEvent {}

class CompleteNextOnboardingEvent extends OnboardingEvent {}

class CompleteOnboardingEvent extends OnboardingEvent {}

class TimerChangedEvent extends OnboardingEvent {
  final double progress;

  TimerChangedEvent(this.progress);
}

// States for OnboardingBloc
@immutable
sealed class OnboardingState {}

class OnboardingInProgress extends OnboardingState {
  final double progress;

  OnboardingInProgress(this.progress);
}

class OnboardingCompletedState extends OnboardingState {}

class NextOnboadingState extends OnboardingState {}

class HomeScreenState extends OnboardingState {}

// BLoC class for managing onboarding logic
class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final TimerService _timerservice;
  double progress = 0.0;

  // Tracking whether the user is in onboarding or next onboarding screen.
  bool _isInNextOnboarding = false;

  OnboardingBloc(this._timerservice) : super(OnboardingInProgress(0.0)) {
    on<StartOnboardingEvent>((event, emit) async {
      _isInNextOnboarding = false;
      await _startProgressStream(emit);
    });

    on<StartNextOnboardingEvent>((event, emit) async {
      _isInNextOnboarding = true;
      await _startProgressStream(emit);
    });

    on<SkipOnboardingEvent>((event, emit) {
      _cancelTimerAndNavigate(emit, HomeScreenState());
    });

    on<CompleteOnboardingEvent>((event, emit) {
      _cancelTimerAndNavigate(emit, NextOnboadingState());
    });

    on<CompleteNextOnboardingEvent>((event, emit) {
      _cancelTimerAndNavigate(emit, OnboardingCompletedState());
    });

    on<TimerChangedEvent>((event, emit) {
      emit(OnboardingInProgress(event.progress));
    });
  }

  // Method to handle progress and timer management based on screen type.
  Future<void> _startProgressStream(Emitter<OnboardingState> emit) async {
    progress = 0.0;
    _timerservice
        .cancelTimer(); // Ensure any previous timer is cancelled before starting a new one.

    void callBackFunction(Timer timer) {
      progress += 0.008;
      add(TimerChangedEvent(progress));

      if (progress >= 1.0) {
        _timerservice.cancelTimer();
        if (_isInNextOnboarding) {
          add(CompleteNextOnboardingEvent());
        } else {
          add(CompleteOnboardingEvent());
        }
      }
    }

    _timerservice.startPerodicTimer(
        const Duration(milliseconds: 30), callBackFunction);
  }

  void _cancelTimerAndNavigate(
      Emitter<OnboardingState> emit, OnboardingState state) {
    _timerservice.cancelTimer();
    emit(state);
  }

  @override
  Future<void> close() {
    _timerservice.cancelTimer();
    return super.close();
  }
}
