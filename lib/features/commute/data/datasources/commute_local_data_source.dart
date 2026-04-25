import 'package:urban_life_modeler/core/errors/exceptions.dart';
import 'package:urban_life_modeler/features/commute/data/models/commute_model.dart';

abstract class CommuteLocalDataSource {
  ///Get profile data from cache data
  ///
  /// Throw a [CacheException] for all the cache error code


  Future<void> cacheCommuteProfile(CommuteModel profile);

  Future<CommuteModel> getLastCommuteProfile();
}
