part of 'app_cubit.dart';

class BaseAppState {
  BaseAppState(this.url);

  final String? url;
}

class InitAppState extends BaseAppState {
  InitAppState(super.url);
}
class LoadingAppState extends BaseAppState {
  LoadingAppState(
    this.progress,
    super.url
  );

  final double progress;
}

class SuccessAppState extends BaseAppState {
  final ApiResponse response;
  SuccessAppState(this.response, super.url);
}

class SuccessProcessState extends BaseAppState {
  final List<TaskSolutionModel> solutions;
  SuccessProcessState(this.solutions, super.url);
}

class ErrorAppState extends BaseAppState {
  ErrorAppState(this.error, super.url);
  final String? error;
}
