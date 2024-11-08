part of 'tasklist_bloc.dart';

@immutable
sealed class TaskListState {}

class TaskListInitialState extends TaskListState {}

class TaskListLoadingState extends TaskListState {}

class TaskListSuccessState extends TaskListState {
  final List<TaskEntity> item;

  TaskListSuccessState(this.item);
}

class TaskListEmptyState extends TaskListState {}

class TaskListErrorState extends TaskListState {
  final String errorMessage;

  TaskListErrorState(this.errorMessage);
}
