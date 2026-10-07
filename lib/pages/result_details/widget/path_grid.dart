import 'package:flutter/material.dart';
import 'package:webspark_test/data/model/point_model.dart';
import 'package:webspark_test/data/model/task_model.dart';
import 'package:webspark_test/data/model/task_solution_model.dart';

class PathGrid extends StatelessWidget {
  const PathGrid({
    super.key,
    required this.task,
    required this.solution,
  });

  final TaskModel task;
  final TaskSolutionModel solution;

  @override
  Widget build(BuildContext context) {
    final rows = task.field.length;
    final columns = task.field.first.length;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
      ),
      itemCount: rows * columns,
      itemBuilder: (context, index) {
        final row = index ~/ columns;
        final column = index % columns;

        final point = PointModel(
          column,
          row,
        );

        return _GridCell(
          point: point,
          color: _getCellColor(point),
        );
      },
    );
  }

  Color _getCellColor(PointModel point) {
    if (_isSamePoint(point, task.start)) {
      return const Color(0xFF64FFDA);
    }

    if (_isSamePoint(point, task.end)) {
      return const Color(0xFF009688);
    }

    if (_isBlocked(point)) {
      return const Color(0xFF000000);
    }

    if (_isPath(point)) {
      return const Color(0xFF4CAF50);
    }

    return const Color(0xFFFFFFFF);
  }

  bool _isSamePoint(
      PointModel a,
      PointModel b,
      ) {
    return a.x == b.x && a.y == b.y;
  }

  bool _isBlocked(PointModel point) {
    final value = task.field[point.x][point.y];

    return value.toLowerCase() == 'x';
  }

  bool _isPath(PointModel point) {
    return solution.steps.any(
          (step) => _isSamePoint(step, point),
    );
  }
}
class _GridCell extends StatelessWidget {
  const _GridCell({
    required this.point,
    required this.color,
  });

  final PointModel point;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: Colors.grey.shade400,
          width: 0.5,
        ),
      ),
      child: Center(
        child: Text(
          '(${point.x},${point.y})',
          style: TextStyle(
            color: color.computeLuminance() > 0.5
                ? Colors.black
                : Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

