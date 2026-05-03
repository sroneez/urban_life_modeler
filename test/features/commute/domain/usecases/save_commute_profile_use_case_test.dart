import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:urban_life_modeler/core/errors/failure.dart';
import 'package:urban_life_modeler/features/commute/domain/entities/commute_profile.dart';
import 'package:urban_life_modeler/features/commute/domain/repositories/commute_repository.dart';
import 'package:urban_life_modeler/features/commute/domain/usecases/save_commute_profile_use_case.dart';

class MockCommuteRepository extends Mock implements CommuteRepository {}

void main() {
  late SaveCommuteProfileUseCase useCase;
  late MockCommuteRepository mockRepository;

  setUp(() {
    mockRepository = MockCommuteRepository();
    useCase = SaveCommuteProfileUseCase(commuteRepository: mockRepository);
  });

  final tProfile = CommuteProfile(
    id: 'test_id',
    departureTime: DateTime(2026, 1, 1),
    durationMinutes: 30,
    transitMode: 'Bus',
  );

  test(
    'should pass the profile to the repository and return Right(unit) upon success',
    () async {
      when(
        () => mockRepository.saveCommuteProfile(tProfile),
      ).thenAnswer((_) async => const Right(unit));
      final result = await useCase(tProfile);
      expect(result, Right(unit));
      verify(() => mockRepository.saveCommuteProfile(tProfile)).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test(
    'should return Left(CacheFailure) when repository fails to save',
    () async {
      when(() => mockRepository.saveCommuteProfile(tProfile)).thenAnswer(
        (_) async => Left<Failure, Unit>(CacheFailure(message: 'Storage full')),
      );

      final result = await useCase(tProfile);

      expect(
        result,
       const Left<Failure, Unit>(CacheFailure(message: 'Storage full')),
      );

      verify(() => mockRepository.saveCommuteProfile(tProfile)).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
