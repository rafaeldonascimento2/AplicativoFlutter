import 'package:flutter_application_1/features/auth/core/dao/user_firebase_dao.dart';
import 'package:flutter_application_1/features/cart/core/dao/cart_firebase_dao.dart';
import 'package:flutter_application_1/features/favorites/core/dao/favorites_firebase_dao.dart';
import 'package:flutter_application_1/features/menu/core/dao/menu_firebase_dao.dart';
import 'package:flutter_application_1/features/order/core/dao/order_firebase_dao.dart';
import 'package:get_it/get_it.dart';

abstract class DI {
  static final GetIt getIt = GetIt.instance;

  static void setDependencies() {
    // getIt.registerLazySingleton(() => UserRamMemoryDao());
    // getIt.registerLazySingleton(() => MenuRamMemoryDao());
    // getIt.registerLazySingleton(() => OrderRamMemoryDao());
    // getIt.registerLazySingleton(() => CartRamMemoryDao());
    // getIt.registerLazySingleton(() => FavoritesRamMemoryDao());

    getIt.registerFactory(() => FirebaseUserDao());
    getIt.registerFactory(() => MenuFirestoreDao());

    getIt.registerFactoryParam<OrderFirestoreDao, String, void>(
      (userId, _) => OrderFirestoreDao(userId: userId),
    );

    getIt.registerFactoryParam<CartFirestoreDao, String, void>(
      (userId, _) => CartFirestoreDao(userId: userId),
    );

    getIt.registerFactoryParam<FavoritesFirestoreDao, String, void>(
      (userId, _) => FavoritesFirestoreDao(userId: userId),
    );
  }
}
