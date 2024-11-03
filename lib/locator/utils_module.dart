import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

void setup(GetIt getIt) {
  /*
    This should be exited throughout the application life cycle 
  */
  getIt.registerSingleton<Logger>(Logger());
}
