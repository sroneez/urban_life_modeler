import 'package:dartz/dartz.dart';
import 'package:urban_life_modeler/core/errors/failure.dart';
import 'package:urban_life_modeler/features/environments/domain/entities/environment_state.dart';
import 'package:urban_life_modeler/features/environments/domain/repositories/environmental_repository.dart';

class GetCurrentEnvironmentUseCase {
  final EnvironmentalRepository repository;
  GetCurrentEnvironmentUseCase({required this.repository});
  Future<Either<Failure,EnvironmentalState>> call({required String locationId}) async{
    if(locationId.isEmpty){
      return Left(ValidationFailure(message: 'Location Id can not be empty'));
    }
    return await repository.getCurrentEnvironment(locationId: locationId);
  }
}