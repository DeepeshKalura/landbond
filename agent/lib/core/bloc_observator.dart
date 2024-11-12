import 'package:flutter_bloc/flutter_bloc.dart';
import '../locator/injector.dart' as di;

import 'package:logger/logger.dart';

class BlocObservationLogger extends BlocObserver {
  final logger = di.injector.get<Logger>();
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    logger.i("Bloc: $bloc -- Transition: $transition");
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    logger.e(
        'Bloc -- ${bloc.runtimeType} \nError -- $error \nStackTrack -- $stackTrace');
  }
}
