import 'package:adoodlz/blocs/models/gift.dart';

abstract class IGiftsApi {
  Future<List<Gift>> fetchGifts();
  Future<bool> useGifts(String giftId, String userId, int points);
}
