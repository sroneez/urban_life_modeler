import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_life_modeler/features/environments/domain/usecases/get_current_environment_use_case.dart';
import 'package:urban_life_modeler/features/environments/presentation/cubit/environment_cubit_state.dart';

class EnvironmentCubit extends Cubit<EnvironmentCubitState> {
  final GetCurrentEnvironmentUseCase getEnvironmentUseCase;

  EnvironmentCubit({required this.getEnvironmentUseCase})
    : super(EnvironmentInitial());

  Future<void> fetchEnvironment(String locationId) async {
    emit(EnvironmentLoading());

    final result = await getEnvironmentUseCase(locationId: locationId);
    result.fold(
      (error) => emit(EnvironmentError(message: error.message)),
      (success) => emit(EnvironmentLoaded(environment: success)),
    );
  }
}
