import 'package:dartz/dartz.dart';
import 'package:urban_life_modeler/core/errors/failure.dart';
import 'package:urban_life_modeler/features/commute/domain/entities/commute_profile.dart';

abstract class CommuteRepository {
  Future<Either<Failure, Unit>> saveCommuteProfile(CommuteProfile profile);
}
