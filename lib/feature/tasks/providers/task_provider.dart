import 'package:adoodlz/feature/tasks/data/models/submitted_task.dart';
import 'package:adoodlz/feature/tasks/data/models/task_model.dart';
import 'package:adoodlz/feature/tasks/data/repo/task_api.dart';
import 'package:flutter/material.dart';

class TaskProvider extends ChangeNotifier {
  final TaskApi _taskApi;
  TaskApi _submittedTaskApi;
  bool _loading;
  bool _loading2;
  bool _finish;
  List<TaskModel> tasks;
  List<SubmittedTaskModel> submittedTasks;

  TaskProvider(
    this._taskApi,
    /* this._submittedTaskApi*/
  )   : _loading = false,
        _loading2 = false;

  set loading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  // ignore: avoid_setters_without_getters
  set loading2(bool loading2) {
    _loading2 = loading2;
    notifyListeners();
  }

  bool get loading => _loading;
  bool get loading2 => _loading2;

  Future<bool> submitTask(Map<String, dynamic> formData) async {
    try {
      loading = true;
      _finish = await _taskApi.submitTask(formData);
      loading = false;
      return _finish;
    } catch (e) {
      loading = false;
      debugPrint(e.toString());
      //rethrow;
      return false;
    } finally {
      loading = false;
    }
  }

  Future<List<TaskModel>> getTasks() async {
    try {
      loading2 = true;
      // ignore: join_return_with_assignment
      tasks = await _taskApi.fetchTasks();
      return tasks;
    } catch (e) {
      rethrow;
    } finally {
      loading2 = false;
    }
  }

  Future<List<TaskModel>> getSubmittedTasks() async {
    try {
      loading2 = true;
      // ignore: join_return_with_assignment
      submittedTasks = await _submittedTaskApi.fetchSubmittedTasks();
      return tasks;
    } catch (e) {
      rethrow;
    } finally {
      loading2 = false;
    }
  }
}
