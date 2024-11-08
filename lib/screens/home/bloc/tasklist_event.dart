part of 'tasklist_bloc.dart';

@immutable
sealed class TaskListEvent {}

class TaskListStartedEvent extends TaskListEvent {}

class TaskListSearchEvent extends TaskListEvent {
  final String searchTerm;

  TaskListSearchEvent(this.searchTerm);
}

class TaskListDeleteAllEvent extends TaskListEvent {}
