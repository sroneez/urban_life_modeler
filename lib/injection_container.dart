import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:urban_life_modeler/features/environments/data/datasources/environment_remote_data_source_impl.dart';
import 'package:urban_life_modeler/features/environments/data/repositories/environment_repository_impl.dart';
import 'package:urban_life_modeler/features/environments/domain/repositories/environmental_repository.dart';

import 'features/environments/data/datasources/environment_remote_data_source.dart';
import 'features/environments/domain/usecases/get_current_environment_use_case.dart';
import 'features/environments/presentation/cubit/environment_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // 1. Core: Configure Dio ONCE
  // sl.registerLazySingleton(() {
  //   final dio = Dio(BaseOptions(baseUrl: Env.weatherBaseUrl));
  //   dio.interceptors.add(CustomDioInterceptor()); // Handles keys and errors
  //   return dio;
  // });

  // 2. Data Sources: Give them the configured Dio
  sl.registerLazySingleton<EnvironmentRemoteDataSource>(
        () => EnvironmentRemoteDatasourceImpl(dio: sl()),
  );

  // 3. Repositories
  sl.registerLazySingleton<EnvironmentalRepository>(
        () => EnvironmentRepositoryImpl( remoteDataSource: sl()),
  );

  // 4. Use Cases
  sl.registerLazySingleton(() => GetCurrentEnvironmentUseCase(repository: sl()));

  // 5. Presentation (Cubits)
  sl.registerFactory(() => EnvironmentCubit(getEnvironmentUseCase: sl()));
}