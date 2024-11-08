import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/data/data.dart';
import 'package:todo/data/repo/repository.dart';

part 'tasklist_state.dart';
part 'tasklist_event.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  final Repository<TaskEntity> repository;
  TaskListBloc(this.repository) : super(TaskListInitial()) {
    on<TaskListEvent>(
      (event, emit) async {
        if (event is TaskListStarted || event is TaskListSearch) {
          final String searchTerm;
          emit(TaskListLoading());

          if (event is TaskListSearch) {
            searchTerm = event.searchTerm;
          } else {
            searchTerm = '';
          }

          final item = await repository.getAll(searchKeyword: searchTerm);
          try {
            if (item.isNotEmpty) {
              emit(TaskListSuccess(item));
            } else {
              emit(TaskListEmpty());
            }
          } catch (e) {
            emit(
              TaskListError(
                e.toString(),
              ),
            );
          }
        } else if (event is TaskListDeleteAll) {
          await repository.deleteAll();
          emit(TaskListEmpty());
        }
      },
    );
  }
}
