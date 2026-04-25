import 'package:dartz/dartz.dart';
import 'package:urban_life_modeler/core/errors/exceptions.dart';
import 'package:urban_life_modeler/core/errors/failure.dart';
import 'package:urban_life_modeler/features/commute/data/datasources/commute_local_data_source.dart';
import 'package:urban_life_modeler/features/commute/data/models/commute_model.dart';
import 'package:urban_life_modeler/features/commute/domain/entities/commute_profile.dart';
import 'package:urban_life_modeler/features/commute/domain/repositories/commute_repository.dart';

class CommuteRepositoryImpl extends CommuteRepository {
  final CommuteLocalDataSource localDataSource;

  CommuteRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, Unit>> saveCommuteProfile(
    CommuteProfile profile,
  ) async {
    final model = CommuteModel(
      id: profile.id,
      departureTime: profile.departureTime,
      durationMinutes: profile.durationMinutes,
      transitMode: profile.transitMode,
    );
    try {
      await localDataSource.cacheCommuteProfile(model);
      return Right(unit);
    } on CacheException catch (e) {
      throw Left(CacheException('Failed to cache profile:${e.message}'));
    } catch (e) {
      throw Left(CacheException('Unexpected error:$e'));
    }
  }
}
