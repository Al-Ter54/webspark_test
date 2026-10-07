
import 'package:webspark_test/data/model/task_model.dart';
import 'package:webspark_test/data/model/task_solution_model.dart';
import 'package:webspark_test/services/path_finder.dart';

class TaskSolver {
  const TaskSolver(this._pathFinder);

  final PathFinder _pathFinder;

  TaskSolutionModel solve(TaskModel task) {
    final steps = _pathFinder.findPath(task);

    final path = steps
        .map(
          (point) => '(${point.x},${point.y})',
    )
        .join('->');

    return TaskSolutionModel(
      id: task.id,
      steps: steps,
      path: path,
    );
  }
}