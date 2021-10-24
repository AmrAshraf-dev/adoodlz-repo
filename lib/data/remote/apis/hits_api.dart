import 'package:adoodlz/blocs/models/hit.dart';
import 'package:adoodlz/data/remote/constants/endpoints.dart';
import 'package:adoodlz/data/remote/dio_client.dart';
import 'package:adoodlz/data/remote/interfaces/i_hits_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class HitsApi implements IHitsApi {
  final DioClient _dioClient;

  HitsApi(this._dioClient);

  @override
  Future<bool> recordHit(Hit hit,
      {String affiliaterId, String affiliatedId}) async {
    try {
      var url = recordHits;
      final hitToSend = hit?.toJson() ?? {};
      if (affiliaterId != null) {
        //&& affiliaterId ==
        url += '/$affiliaterId/$affiliatedId';
      }
      final response = await _dioClient.post(url, data: hitToSend);
      debugPrint(response.toString());
      return true;
    } catch (e) {
      if (e is DioError) {
        debugPrint('Inside recordHit ${e.response.data.toString()}');
      }
      rethrow;
    }
  }
}
