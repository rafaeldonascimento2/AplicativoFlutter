import 'package:flutter_application_1/features/auth/core/dao/user_ram_memory_dao.dart';
import 'package:get_it/get_it.dart';

abstract class DI {
  static final GetIt getIt = GetIt.instance;

  static void setDependencies() {
    getIt.registerLazySingleton(() => UserRamMemoryDao());
  }
}
