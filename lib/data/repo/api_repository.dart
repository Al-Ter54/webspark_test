import 'package:dio/dio.dart';
import 'package:webspark_test/data/model/api_response.dart';
import 'package:webspark_test/data/model/task_solution_model.dart';

class ApiRepositoryImpl implements ApiRepository {
  ApiRepositoryImpl(this._dio);

  final Dio _dio;

  @override
  Future<ApiResponse> get(
      String url, {
        required void Function(double progress) onProgress,
      }) async {
    final response = await _dio.get(
      url,
      onReceiveProgress: (received, total) {
        if (total > 0) {
          onProgress(received / total);
        }
      },
    );

    return ApiResponse.fromMap(
      response.data as Map<String, dynamic>,
    );
  }


  @override
  Future<void> postSolutions(
      String url,
      List<TaskSolutionModel> solutions,
      ) async {
    final data = solutions
        .map((solution) => solution.toJson())
        .toList();

    await _dio.post(
      url,
      data: data,
    );
  }
}

abstract interface class ApiRepository {
  Future<ApiResponse> get(
      String url, {
        required void Function(double progress) onProgress,
      });

  Future<void> postSolutions(
      String url,
      List<TaskSolutionModel> solutions,
      );
}