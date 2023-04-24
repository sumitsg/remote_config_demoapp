import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:remote_congigue_demoapp/data/repositories_impl/app_config_repo_impl.dart';
import 'package:remote_congigue_demoapp/data/services/remote_service.dart';
import 'package:remote_congigue_demoapp/domain/repositories/app_configue_repo.dart';
import 'package:remote_congigue_demoapp/domain/usecase/check_update_usecase.dart';
import 'package:remote_congigue_demoapp/domain/usecase/get_product_list_usecase.dart';
import 'package:remote_congigue_demoapp/domain/usecase/get_product_stream.dart';
import 'package:remote_congigue_demoapp/presentation/bloc/product_detail_bloc.dart';

final GetIt getIt = GetIt.instance;
void setup() {
  getIt.registerLazySingleton<FirebaseRemoteConfig>(
      () => FirebaseRemoteConfig.instance);
  //datasource service
  getIt.registerLazySingleton(() => FirebaseRemoteConfigService(
      firebaseRemoteConfig: getIt<FirebaseRemoteConfig>()));

  //repo impl
  getIt.registerLazySingleton<AppConfigRepository>(
      () => AppConfigRepositoryImpl(remoteConfig: getIt()));

  //domain usercase
  getIt.registerLazySingleton(
      () => GetProdcutDetailsUsecase(getIt<AppConfigRepository>()));
  getIt.registerLazySingleton(
      () => CheckUpdateUsecase(getIt<AppConfigRepository>()));
  getIt.registerLazySingleton(
      () => GetProdcutDetailsStreamUsecase(getIt<AppConfigRepository>()));

  //bloc
  getIt.registerLazySingleton(
      () => ProductDetailBloc(getIt(), getIt(), getIt()));
}
