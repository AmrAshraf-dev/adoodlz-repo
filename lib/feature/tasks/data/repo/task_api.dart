import 'dart:convert';

import 'package:adoodlz/blocs/models/user.dart';
import 'package:adoodlz/data/remote/dio_client.dart';
import 'package:adoodlz/exceptions/fetch_exception.dart';
import 'package:adoodlz/feature/tasks/data/models/submitted_task.dart';
import 'package:adoodlz/feature/tasks/data/models/task_model.dart';
import 'package:adoodlz/helpers/shared_preferences_keys.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:adoodlz/data/remote/constants/endpoints.dart' as endpoints;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TaskApi {
  final DioClient _dioClient;

  TaskApi(this._dioClient);
  User user;
  Future<List<TaskModel>> fetchTasks() async {
    try {
      print(endpoints.getTasks);

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final dataUser = prefs.getString(savedTokenDataKey);
      //Map<String, dynamic>
      final userDecodedData = json.decode(dataUser) as Map<String, dynamic>;
      userId = userDecodedData['id'];

      final response = await _dioClient
          .get(endpoints.getTasks, queryParameters: {"userId": "$userId"});

      if (response != null && (response as List).isNotEmpty) {
        print(response.toString());
        return (response as List)
            .map<TaskModel>(
                (item) => TaskModel.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<SubmittedTaskModel>> fetchSubmittedTasks() async {
    try {
      print(endpoints.taskSubmit);
      final response = await _dioClient.get(endpoints.taskSubmit);
      if (response != null && (response as List).isNotEmpty) {
        print(response.toString());
        return (response as List)
            .map<SubmittedTaskModel>((item) =>
                SubmittedTaskModel.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> submitTask(Map<String, dynamic> formData) async {
    try {
      debugPrint('this our Data live ${formData.toString()}');
      final formDataToSend = FormData.fromMap(formData);

      //debugPrint('this our Data ${formDataToSend.fields.toString()}');

      final dynamic response =
          await _dioClient.post(endpoints.taskSubmit, data: formDataToSend);
      //print('our response Data${response.toString()}');
      if (response != null) {
        print('method Success');
        //print(response['_id'] as String);
        print('my response ${response.toString()}');
        return true;
      } else {
        throw NetworkErrorException();
      }
    } catch (e) {
      rethrow;
    }
  }
}
