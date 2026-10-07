import 'package:webspark_test/data/model/point_model.dart';
import 'package:webspark_test/data/model/task_model.dart';

class PathFinder {
  const PathFinder();

  List<PointModel> findPath(TaskModel task) {
    final field = task.field;

    if (field.isEmpty) {
      return [];
    }

    final rows = field.length;
    final cols = field.first.length;

    final start = task.start;
    final end = task.end;

    if (!_isValidPoint(start, rows, cols) || !_isValidPoint(end, rows, cols)) {
      return [];
    }

    if (!_isWalkable(field, start) || !_isWalkable(field, end)) {
      return [];
    }

    if (_isSamePoint(start, end)) {
      return [start];
    }

    final queue = <PointModel>[start];
    var queueIndex = 0;

    final previous = <String, PointModel?>{_key(start): null};

    while (queueIndex < queue.length) {
      final current = queue[queueIndex++];

      if (_isSamePoint(current, end)) {
        return _restorePath(previous, end);
      }

      for (final neighbor in _getNeighbors(current)) {
        if (!_isValidPoint(neighbor, rows, cols)) {
          continue;
        }

        if (!_isWalkable(field, neighbor)) {
          continue;
        }

        final key = _key(neighbor);

        if (previous.containsKey(key)) {
          continue;
        }

        previous[key] = current;
        queue.add(neighbor);
      }
    }

    return [];
  }

  List<PointModel> _getNeighbors(PointModel point) {
    return [
      PointModel(point.x - 1, point.y),
      PointModel(point.x + 1, point.y),
      PointModel(point.x, point.y - 1),
      PointModel(point.x, point.y + 1),
      PointModel(point.x - 1, point.y - 1),
      PointModel(point.x + 1, point.y - 1),
      PointModel(point.x - 1, point.y + 1),
      PointModel(point.x + 1, point.y + 1),
    ];
  }

  bool _isValidPoint(PointModel point, int rows, int cols) {
    return point.x >= 0 && point.x < cols && point.y >= 0 && point.y < rows;
  }

  bool _isWalkable(List<String> field, PointModel point) {
    final cell = field[point.y][point.x];

    return cell != 'X' && cell != 'x';
  }

  bool _isSamePoint(PointModel first, PointModel second) {
    return first.x == second.x && first.y == second.y;
  }

  String _key(PointModel point) {
    return '${point.x}:${point.y}';
  }

  List<PointModel> _restorePath(
    Map<String, PointModel?> previous,
    PointModel end,
  ) {
    final path = <PointModel>[];

    PointModel? current = end;

    while (current != null) {
      path.add(current);
      current = previous[_key(current)];
    }

    return path.reversed.toList();
  }
}
