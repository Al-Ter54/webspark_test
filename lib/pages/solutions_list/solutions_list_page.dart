import 'package:flutter/material.dart';
import 'package:webspark_test/data/model/task_model.dart';
import 'package:webspark_test/data/model/task_solution_model.dart';
import 'package:webspark_test/pages/result_details/result_details_page.dart';

class SolutionsListPage extends StatelessWidget {
  const SolutionsListPage({
    super.key,
    required this.solutions,
    required this.tasks,
  });

  final List<TaskSolutionModel> solutions;
  final List<TaskModel> tasks;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: solutions.length,
        separatorBuilder: (_, __) {
          return const SizedBox(height: 8);
        },
        itemBuilder: (context, index) {
          final solution = solutions[index];

          final task = tasks.firstWhere(
                (task) => task.id == solution.id,
          );

          return _ResultCard(
            solution: solution,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ResultDetailsPage(
                    solution: solution,
                    task: task,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({
    required this.solution,
    required this.onTap,
  });

  final TaskSolutionModel solution;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(
          'Task ${solution.id}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          solution.path,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(
          Icons.chevron_right,
        ),
      ),
    );
  }
}

