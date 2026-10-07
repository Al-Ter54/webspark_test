import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webspark_test/application/app.dart';
import 'package:webspark_test/application/dio_client.dart';
import 'package:webspark_test/bloc/link/app_cubit.dart';
import 'package:webspark_test/data/repo/api_repository.dart';
import 'package:webspark_test/data/repo/link_repository.dart';
import 'package:webspark_test/data/source/link_local_datasource.dart';
import 'package:webspark_test/services/path_finder.dart';
import 'package:webspark_test/services/task_solver.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final preferences = await SharedPreferences.getInstance();

  final localDataSource = LinkLocalDataSource(preferences);

  final linkRepository = LinkRepositoryImpl(localDataSource);

  final dioClient = DioClient();

  final apiRepository = ApiRepositoryImpl(dioClient.dio);
  final pathFinder = PathFinder();

  final taskSolver = TaskSolver(pathFinder);

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<LinkRepository>.value(value: linkRepository),
        RepositoryProvider<ApiRepository>.value(value: apiRepository),
      ],
      child: BlocProvider(
        create: (context) => AppCubit(
          context.read<LinkRepository>(),
          context.read<ApiRepository>(),
          taskSolver,
        ),
        child: App(),
      ),
    ),
  );
}
