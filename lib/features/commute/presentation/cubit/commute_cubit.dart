import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_life_modeler/features/commute/domain/entities/commute_profile.dart';
import 'package:urban_life_modeler/features/commute/domain/usecases/save_commute_profile_use_case.dart';
import 'package:urban_life_modeler/features/commute/presentation/cubit/commute_cubit_state.dart';

class CommuteCubit extends Cubit<CommuteCubitState> {
  final SaveCommuteProfileUseCase commuteProfileUseCase;

  CommuteCubit({required this.commuteProfileUseCase}) : super(CommuteInitial());

  Future<void> saveCommuteData(CommuteProfile commuteProfile) async {
    emit(CommuteSaving());

    final result = await commuteProfileUseCase(commuteProfile);
    result.fold(
      (failure) => emit(CommuteError(message: failure.message)),
      (success) => emit(CommuteSaveSuccess()),
    );
  }
}
