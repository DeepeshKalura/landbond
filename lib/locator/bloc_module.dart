import 'package:get_it/get_it.dart';

import '../presentation/home/bloc/home_bloc.dart';

void setup(GetIt getIt) {
  /*
    This should be exited throughout the application life cycle 
  */
  getIt.registerLazySingleton<HomeBloc>(
    () => HomeBloc(),
  );
}
