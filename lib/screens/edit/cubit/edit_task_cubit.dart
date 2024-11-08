import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/data/data.dart';
import 'package:todo/data/repo/repository.dart';

part 'edit_task_state.dart';

class EditTaskCubit extends Cubit<EditTaskState> {
  final TaskEntity _task;
  final Repository<TaskEntity> repository;
  EditTaskCubit(this._task, this.repository) : super(EditTaskInitial(_task));

  void onSaveChangesClick() {
    repository.createOrUpdate(_task);
  }

  void onTextChanged(String text) {
    _task.name = text;
  }

  void onPriorityChanged(Priority priority) {
    _task.priority = priority;
    emit(EditTaskPriorityChange(_task));
  }
}
