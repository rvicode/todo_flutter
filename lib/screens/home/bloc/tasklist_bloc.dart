import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/data/data.dart';
import 'package:todo/data/repo/repository.dart';

part 'tasklist_state.dart';
part 'tasklist_event.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  final Repository<TaskEntity> repository;
  TaskListBloc(this.repository) : super(TaskListInitialState()) {
    on<TaskListEvent>(
      (event, emit) async {
        if (event is TaskListStartedEvent || event is TaskListSearchEvent) {
          final String searchTerm;
          emit(TaskListLoadingState());

          if (event is TaskListSearchEvent) {
            searchTerm = event.searchTerm;
          } else {
            searchTerm = '';
          }

          final item = await repository.getAll(searchKeyword: searchTerm);
          try {
            if (item.isNotEmpty) {
              emit(TaskListSuccessState(item));
            } else {
              emit(TaskListEmptyState());
            }
          } catch (e) {
            emit(
              TaskListErrorState(
                e.toString(),
              ),
            );
          }
        } else if (event is TaskListDeleteAllEvent) {
          await repository.deleteAll();
          emit(TaskListEmptyState());
        }
      },
    );
  }
}
