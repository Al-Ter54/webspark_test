import 'dart:convert';

import 'package:webspark_test/data/model/task_model.dart';

class ApiResponse {
  final bool error;
  final String message;
  final List<TaskModel> body;
  ApiResponse({
    required this.error,
    required this.message,
    required this.body,
  });

  bool get isFailure => error;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'error': error,
      'message': message,
      'data': body
        .map((task) => task.toJson())
        .toList(),
    };
  }

  factory ApiResponse.fromMap(Map<String, dynamic> map) {
    return ApiResponse(
      error: map['error'] as bool,
      message: map['message'] as String,
      body: (map['data'] as List)
          .map(
            (item) => TaskModel.fromJson(
          item as Map<String, dynamic>,
        ),
      )
          .toList(),
    );
  }

  String toJsonStr() => json.encode(toJson());

  factory ApiResponse.fromJson(String source) =>
      ApiResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}