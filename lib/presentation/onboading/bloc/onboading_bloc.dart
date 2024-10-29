import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Events for OnboardingBloc
@immutable
sealed class OnboardingEvent {}

class StartOnboardingEvent extends OnboardingEvent {}

class SkipOnboardingEvent extends OnboardingEvent {}

class StartNextOnboardingEvent extends OnboardingEvent {}

class CompleteNextOnboardingEvent extends OnboardingEvent {}

class CompleteOnboardingEvent extends OnboardingEvent {}

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
  double progress = 0.0;

  OnboardingBloc() : super(OnboardingInProgress(0.0)) {
    on<StartOnboardingEvent>((event, emit) async {
      await _startProgressStream(emit, type: 1);
    });

    on<SkipOnboardingEvent>((event, emit) {
      emit(HomeScreenState());
    });

    on<CompleteOnboardingEvent>((event, emit) {
      emit(NextOnboadingState());
    });

    on<CompleteNextOnboardingEvent>((event, emit) {
      emit(OnboardingCompletedState());
    });

    on<StartNextOnboardingEvent>((event, emit) async {
      await _startProgressStream(emit, type: 2);
    });
  }

  // TODO: I am not be able to make this function work Make the silder work ok

  // It need to work with the stream

  Future<void> _startProgressStream(Emitter<OnboardingState> emit,
      {required int type}) async {
    progress = 0.0;
    emit(OnboardingInProgress(progress));

    while (progress < 1.0) {
      await Future.delayed(const Duration(milliseconds: 100));
      progress += 0.02;
    }
    if (progress >= 1.0) {
      if (type == 1) {
        emit(NextOnboadingState());
      } else {
        emit(OnboardingCompletedState());
      }
    }
  }
}
