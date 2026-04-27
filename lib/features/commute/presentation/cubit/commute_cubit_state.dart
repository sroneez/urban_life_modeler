
abstract class CommuteCubitState {}

class CommuteInitial extends CommuteCubitState {}

class CommuteSaving extends CommuteCubitState {}

class CommuteSaveSuccess extends CommuteCubitState {}

class CommuteError extends CommuteCubitState {
  final String message;

  CommuteError({required this.message});
}
