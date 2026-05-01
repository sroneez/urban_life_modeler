import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urban_life_modeler/features/commute/data/datasources/commute_local_data_source.dart';
import 'package:urban_life_modeler/features/commute/data/datasources/commute_local_data_source_impl.dart';
import 'package:urban_life_modeler/features/commute/data/repository/commute_repository_impl.dart';
import 'package:urban_life_modeler/features/commute/domain/repositories/commute_repository.dart';
import 'package:urban_life_modeler/features/commute/domain/usecases/save_commute_profile_use_case.dart';
import 'package:urban_life_modeler/features/commute/presentation/cubit/commute_cubit.dart';
import 'package:urban_life_modeler/features/environments/data/datasources/environment_remote_data_source.dart';
import 'package:urban_life_modeler/features/environments/data/datasources/environment_remote_data_source_impl.dart';
import 'package:urban_life_modeler/features/environments/data/repositories/environment_repository_impl.dart';
import 'package:urban_life_modeler/features/environments/domain/repositories/environmental_repository.dart';
import 'package:urban_life_modeler/features/environments/domain/usecases/get_current_environment_use_case.dart';
import 'package:urban_life_modeler/features/environments/presentation/cubit/environment_cubit.dart';

import 'core/env/env.dart';
import 'core/network/custom_auth_interceptor.dart';

final sl = GetIt.instance;

Future<void> init() async {
  ///registerFactory => a new instance created every time requested
  ///
  /// registerLazySingleton => Only created once stays in memory

  ///============================
  ///CORE & EXTERNAL
  ///============================

  //Shared Preference
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // Dio
  final dio = Dio(
    BaseOptions(
      baseUrl: Env.weatherBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  dio.interceptors.add(CustomAuthInterceptor());

  dio.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ),
  );
  sl.registerLazySingleton(() => dio);

  ///=============================
  ///Feature: Environment
  ///=============================

  //Presentation layer
  sl.registerFactory(() => EnvironmentCubit(getEnvironmentUseCase: sl()));

  //Domain Layer
  sl.registerLazySingleton(
    () => GetCurrentEnvironmentUseCase(repository: sl()),
  );

  //Data Layer
  sl.registerLazySingleton<EnvironmentalRepository>(
    () => EnvironmentRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<EnvironmentRemoteDataSource>(
    () => EnvironmentRemoteDatasourceImpl(dio: sl()),
  );

  ///=============================
  ///Feature: Commute
  ///=============================

  //Presentation layer
  sl.registerFactory(() => CommuteCubit(commuteProfileUseCase: sl()));

  //Domain Layer
  sl.registerLazySingleton(
    () => SaveCommuteProfileUseCase(commuteRepository: sl()),
  );

  //Data Layer
  sl.registerLazySingleton<CommuteRepository>(
    () => CommuteRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<CommuteLocalDataSource>(
    () => CommuteLocalDataSourceImpl(preferences: sl()),
  );
}
