import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import "package:landbond/locator/injector.dart" as di;

import 'firebase_options.dart';
import 'core/app_routes.dart';
import 'core/bloc_observator.dart';
import 'presentation/auth/bloc/auth_bloc.dart';
import 'presentation/onboading/bloc/onboading_bloc.dart';
import 'presentation/splash/bloc/splash_bloc.dart';
import 'service/database/shared_preferences_service.dart';
import 'service/firebase/authenticate_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = BlocObservationLogger();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => SplashBloc(
            di.injector.get<SharedPreferencesService>(),
            di.injector.get<AuthenticateService>(),
          ),
        ),
        BlocProvider(
          create: (context) => OnboardingBloc(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRoutes.router,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
