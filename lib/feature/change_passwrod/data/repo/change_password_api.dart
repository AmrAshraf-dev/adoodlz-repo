import 'package:adoodlz/blocs/models/user.dart';
import 'package:adoodlz/data/remote/dio_client.dart';
import 'package:adoodlz/exceptions/fetch_exception.dart';
import 'package:dio/dio.dart';
import 'package:adoodlz/data/remote/constants/endpoints.dart' as endpoints;
import 'package:flutter/foundation.dart';

class ChangePasswordApi {

  final DioClient _dioClient;
  ChangePasswordApi(this._dioClient);

  Future<User> changePasswordUser(Map<String, dynamic> formData) async {
    try {
      //final formDataToSend = FormData.fromMap(formData);
      //debugPrint(formDataToSend.toString());
      final dynamic response = await _dioClient.put(
        endpoints.getUsers,
        data: formData,
      );
      print(response.toString());
      if (response['user'] != null) {
        print(response['user'].toString());
        return User.fromJson(response['user'] as Map<String, dynamic>);
      } else {
        throw NetworkErrorException();
      }
    } catch (e) {
      if (e is DioError) {
        debugPrint(e.response.data.toString());
      }
      rethrow;
    }
  }
}