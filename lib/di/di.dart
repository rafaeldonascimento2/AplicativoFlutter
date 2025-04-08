import 'package:flutter_application_1/features/auth/core/dao/user_ram_memory_dao.dart';
import 'package:flutter_application_1/features/cart/core/dao/cart_ram_memory_dao.dart';
import 'package:flutter_application_1/features/favorites/core/dao/favorites_ram_memory_dao.dart';
import 'package:flutter_application_1/features/menu/core/dao/menu_ram_memory_dao.dart';
import 'package:flutter_application_1/features/order/core/dao/order_ram_memory_dao.dart';
import 'package:get_it/get_it.dart';

abstract class DI {
  static final GetIt getIt = GetIt.instance;

  static void setDependencies() {
    getIt.registerLazySingleton(() => UserRamMemoryDao());
    getIt.registerLazySingleton(() => MenuRamMemoryDao());
    getIt.registerLazySingleton(() => OrderRamMemoryDao());
    getIt.registerLazySingleton(() => CartRamMemoryDao());
    getIt.registerLazySingleton(() => FavoritesRamMemoryDao());
  }
}
