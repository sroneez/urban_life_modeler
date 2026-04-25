import 'package:urban_life_modeler/features/environments/data/models/environment_model.dart';

abstract class EnvironmentLocalDataSource {
  /// get Environment data from cache base on the location Id
  ///
  /// Throw a [CacheException] for all the cache error codes.

  Future<EnvironmentModel> getCachedEnvironment({required String locationId});
}
