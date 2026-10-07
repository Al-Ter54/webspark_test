import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark_test/bloc/link/app_cubit.dart';
import 'package:webspark_test/data/model/task_model.dart';
import 'package:webspark_test/data/model/task_solution_model.dart';
import 'package:webspark_test/pages/solutions_list/solutions_list_page.dart';

class ProcessingPage extends StatefulWidget {
  const ProcessingPage({super.key, required this.tasks});

  final List<TaskModel> tasks;

  @override
  State<ProcessingPage> createState() => _ProcessingPageState();
}

class _ProcessingPageState extends State<ProcessingPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Processing')),
      body: BlocConsumer<AppCubit, BaseAppState>(
        listener: (context, state) {
          if (state is ErrorAppState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error ?? '')));
          }
        },
        builder: (context, state) {
          if (state is LoadingAppState) {
            return Center(
              child: Column(
                mainAxisAlignment: .center,
                crossAxisAlignment: .center,
                children: [
                  LinearProgressIndicator(value: state.progress),
                  const SizedBox(height: 16),
                  Text('${(state.progress * 100).toInt()}%'),
                ],
              ),
            );
          }

          if (state is SuccessProcessState) {
            return Center(
              child: Column(
                mainAxisAlignment: .center,
                crossAxisAlignment: .center,
                children: [
                  Text('Solution saved'),
                  ElevatedButton(
                    onPressed: () => _goToList(state.solutions),
                    child: Text('Go to list'),
                  ),
                ],
              ),
            );
          }

          if (state is ErrorAppState) {
            return Center(child: Text(state.error ?? ''));
          }

          return Center(
            child: Column(
              crossAxisAlignment: .center,
              mainAxisAlignment: .center,
              children: [
                Text('We are ready to process'),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.read<AppCubit>().process(widget.tasks),
                  child: Text('Process and send'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _goToList(List<TaskSolutionModel> solutions) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) =>
            SolutionsListPage(solutions: solutions, tasks: widget.tasks),
      ),
    );
  }
}
