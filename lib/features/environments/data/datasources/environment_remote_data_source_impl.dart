import 'package:dio/dio.dart';
import 'package:urban_life_modeler/core/errors/exceptions.dart';
import 'package:urban_life_modeler/core/network/api_endpoints.dart';
import 'package:urban_life_modeler/features/environments/data/datasources/environment_remote_data_source.dart';
import 'package:urban_life_modeler/features/environments/data/models/environment_model.dart';

class EnvironmentRemoteDatasourceImpl extends EnvironmentRemoteDataSource {
  final Dio dio;

  EnvironmentRemoteDatasourceImpl({required this.dio});

  @override
  Future<EnvironmentModel> getCurrentEnvironmentModel({
    required String locationId,
  }) async {
    try {
      final response = await dio.get(ApiEndpoints.currentWeather);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return EnvironmentModel.fromJson(response.data);
      } else {
        throw ServerException(
          'Failed with status code: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Network failure occurred');
    } catch (e) {
      throw ServerException("Unexpected error:$e");
    }
  }
}
