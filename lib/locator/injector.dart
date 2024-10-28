import 'package:get_it/get_it.dart';
import './service_module.dart' as service_module;

GetIt injector = GetIt.instance;

Future<void> init() async {
  service_module.setup(injector);
}
