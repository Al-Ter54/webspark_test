import 'point_model.dart';

class TaskSolutionModel {
  const TaskSolutionModel({
    required this.id,
    required this.steps,
    required this.path,
  });

  final String id;
  final List<PointModel> steps;
  final String path;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'result': {
        'steps': steps
            .map(
              (point) => {
            'x': point.x.toString(),
            'y': point.y.toString(),
          },
        )
            .toList(),
        'path': path,
      },
    };
  }
}