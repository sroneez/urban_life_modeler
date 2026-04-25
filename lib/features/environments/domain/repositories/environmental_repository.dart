import 'package:dartz/dartz.dart';
import 'package:urban_life_modeler/core/errors/failure.dart';
import 'package:urban_life_modeler/features/environments/domain/entities/environment_state.dart';

abstract class EnvironmentalRepository{
  Future<Either<Failure,EnvironmentalState>> getCurrentEnvironment({required String locationId});
}