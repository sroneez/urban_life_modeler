import 'package:dartz/dartz.dart';
import 'package:urban_life_modeler/core/errors/failure.dart';
import 'package:urban_life_modeler/features/commute/domain/entities/commute_profile.dart';
import 'package:urban_life_modeler/features/commute/domain/repositories/commute_repository.dart';

class SaveCommuteProfileUseCase {
  final CommuteRepository commuteRepository;

  SaveCommuteProfileUseCase({required this.commuteRepository});

  Future<Either<Failure,Unit>> call(CommuteProfile commuteProfile) async{
    return commuteRepository.saveCommuteProfile(commuteProfile);
  }
}
