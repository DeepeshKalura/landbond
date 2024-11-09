import 'package:get_it/get_it.dart';

import '../service/database/shared_preferences_service.dart';
import '../service/files/image_picker_service.dart';
import '../service/firebase/authenticate_service.dart';
import '../service/timer/timer_service.dart';

void setup(GetIt getIt) {
  getIt.registerLazySingleton<SharedPreferencesService>(
    () => SharedPreferencesService(),
  );

  getIt.registerLazySingleton<FirebaseService>(
    () => FirebaseService(),
  );

  getIt.registerLazySingleton<ImagePickerService>(
    () => ImagePickerService(),
  );

  getIt.registerLazySingleton<TimerService>(() => TimerService());
}
