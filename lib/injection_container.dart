import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urban_life_modeler/features/environments/data/repositories/environment_repository_impl.dart';
import 'package:urban_life_modeler/features/environments/domain/repositories/environmental_repository.dart';
import 'package:urban_life_modeler/features/environments/domain/usecases/get_current_environment_use_case.dart';
import 'package:urban_life_modeler/features/environments/presentation/cubit/environment_cubit.dart';

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

  //Dio
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://exaple.com',
      connectTimeout: Duration(minutes: 1),
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
}
