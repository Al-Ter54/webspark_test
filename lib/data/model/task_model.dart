import 'package:webspark_test/data/model/point_model.dart';


class TaskModel {
  const TaskModel({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
  });

  final String id;
  final List<String> field;
  final PointModel start;
  final PointModel end;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'field': field,
      'start': start.toJson(),
      'end': end.toJson(),
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as String,
      field: List<String>.from(json['field'] as List),
      start: PointModel.fromJson(
        json['start'] as Map<String, dynamic>,
      ),
      end: PointModel.fromJson(
        json['end'] as Map<String, dynamic>,
      ),
    );
  }
}
