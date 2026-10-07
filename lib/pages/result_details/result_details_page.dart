import 'package:flutter/material.dart';
import 'package:webspark_test/data/model/task_model.dart';
import 'package:webspark_test/data/model/task_solution_model.dart';
import 'package:webspark_test/pages/result_details/widget/path_grid.dart';

class ResultDetailsPage extends StatelessWidget {
  const ResultDetailsPage({
    super.key,
    required this.task,
    required this.solution,
  });

  final TaskModel task;
  final TaskSolutionModel solution;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: PathGrid(
          task: task,
          solution: solution,
        ),
      ),
    );
  }
}
