import 'package:urban_life_modeler/features/environments/data/models/environment_model.dart';

abstract class EnvironmentRemoteDataSource{
  ///Fetches the environment data from the given location id
  ///
  /// Throw a [ServerException] for all HTTP error code.
  Future<EnvironmentModel> getCurrentEnvironmentModel({required String locationId});
}