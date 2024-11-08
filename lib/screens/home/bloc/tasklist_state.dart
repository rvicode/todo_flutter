part of 'tasklist_bloc.dart';

@immutable
sealed class TaskListState {}

class TaskListInitial extends TaskListState {}

class TaskListLoading extends TaskListState {}

class TaskListSuccess extends TaskListState {
  final List<TaskEntity> item;

  TaskListSuccess(this.item);
}

class TaskListEmpty extends TaskListState {}

class TaskListError extends TaskListState {
  final String errorMessage;

  TaskListError(this.errorMessage);
}
