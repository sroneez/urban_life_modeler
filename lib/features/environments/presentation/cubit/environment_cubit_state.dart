import 'package:urban_life_modeler/features/environments/domain/entities/environment_state.dart';

abstract class EnvironmentCubitState {}

class EnvironmentInitial extends EnvironmentCubitState {}

class EnvironmentLoading extends EnvironmentCubitState {
  EnvironmentLoading();
}

class EnvironmentLoaded extends EnvironmentCubitState {
  final EnvironmentalState environment;

  EnvironmentLoaded({required this.environment});
}

class EnvironmentError extends EnvironmentCubitState {
  final String message;

  EnvironmentError({required this.message});
}
