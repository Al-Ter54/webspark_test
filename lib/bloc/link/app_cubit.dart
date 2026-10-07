import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark_test/data/model/api_response.dart';
import 'package:webspark_test/data/model/task_model.dart';
import 'package:webspark_test/data/model/task_solution_model.dart';
import 'package:webspark_test/data/repo/api_repository.dart';
import 'package:webspark_test/data/repo/link_repository.dart';
import 'package:webspark_test/services/task_solver.dart';

part 'app_state.dart';

class AppCubit extends Cubit<BaseAppState> {
  AppCubit(this._repository, this._apiRepository, this._taskSolver) : super(InitAppState(null));

  final LinkRepository _repository;
  final ApiRepository _apiRepository;
  final TaskSolver _taskSolver;

  Future<void> saveUrl(String url) async {
    try {
      await _repository.saveLink(url);

      emit(LoadingAppState(0, url));

      final result = await _apiRepository.get(
        url,
        onProgress: (progress) {
          emit(LoadingAppState(progress, url));
        },
      );

      if (result.isFailure) {
        emit(
          ErrorAppState(result.message, url),
        );

        return;
      }
      emit(SuccessAppState(result, url));
    } catch (e) {
      emit(ErrorAppState(e.toString(), url));
    }
  }

  Future<void> loadUrl() async {
    try {
      final url = await _repository.getLink();

      emit(InitAppState(url));
    } catch (e) {
      emit(ErrorAppState(e.toString(), null));
    }
  }

  Future<void> process(
      List<TaskModel> tasks,
      ) async {
    emit(
      LoadingAppState(
        0,
        null,
      ),
    );

    try {
      final url = await _repository.getLink() ?? '';

      final solutions = <TaskSolutionModel>[];

      for (var i = 0; i < tasks.length; i++) {
        final task = tasks[i];

        final solution = _taskSolver.solve(task);

        solutions.add(solution);

        final progress = (i + 1) / tasks.length;

        emit(
          LoadingAppState(
            progress,
            null,
          ),
        );

        await Future<void>.delayed(Duration(seconds: 1));
      }

      await _apiRepository.postSolutions(
        url,
        solutions,
      );


      emit(
        SuccessProcessState(
          solutions,
          null,
        ),
      );
    } catch (e) {
      emit(
        ErrorAppState(
          e.toString(),
          null,
        ),
      );
    }
  }
}
