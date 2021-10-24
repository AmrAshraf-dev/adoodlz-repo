import 'package:adoodlz/blocs/models/gift.dart';
import 'package:adoodlz/data/remote/interfaces/i_gifts_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class GiftsProvider extends ChangeNotifier {
  final IGiftsApi _giftsApi;
  List<Gift> gifts;
  bool _loading;

  bool get loading => _loading;

  set loading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  GiftsProvider(this._giftsApi) : _loading = false;

  Future<List<Gift>> getGifts() async {
    try {
      loading = true;
      // ignore: join_return_with_assignment
      gifts = await _giftsApi.fetchGifts();
      notifyListeners();
      return gifts;
    } catch (e) {
      rethrow;
    } finally {
      loading = false;
    }
  }

  Future<bool> useGift(String giftId, String userId, int points) async {
    try {
      // ignore: join_return_with_assignment
      final success = await _giftsApi.useGifts(giftId, userId, points);

      return success;
    } catch (e) {
      if (e is DioError) {
        debugPrint(e.response.data.toString());
        // ignore: avoid_print
        print('response error');
      }
      rethrow;
    }
  }
}
