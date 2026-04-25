import 'package:dartz/dartz.dart';
import 'package:urban_life_modeler/core/errors/exceptions.dart';
import 'package:urban_life_modeler/core/errors/failure.dart';
import 'package:urban_life_modeler/features/environments/data/datasources/environment_remote_data_source.dart';
import 'package:urban_life_modeler/features/environments/domain/entities/environment_state.dart';
import 'package:urban_life_modeler/features/environments/domain/repositories/environmental_repository.dart';

class EnvironmentRepositoryImpl extends EnvironmentalRepository {
  final EnvironmentRemoteDataSource remoteDataSource;

  EnvironmentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, EnvironmentalState>> getCurrentEnvironment({
    required String locationId,
  }) async {
    try {
      final environmentModel = await remoteDataSource
          .getCurrentEnvironmentModel(locationId: locationId);

      return Right(environmentModel);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.toString()));
    } catch (e) {
      return Left(ServerFailure(message: 'An unexpected error occurred'));
    }
  }
}
