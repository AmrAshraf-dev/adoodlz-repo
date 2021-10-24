import 'package:adoodlz/blocs/models/gift.dart';
import 'package:adoodlz/data/remote/constants/endpoints.dart';
import 'package:adoodlz/data/remote/dio_client.dart';
import 'package:adoodlz/data/remote/interfaces/i_gifts_api.dart';

class GiftsApi implements IGiftsApi {
  final DioClient _dioClient;

  GiftsApi(this._dioClient);

  @override
  Future<List<Gift>> fetchGifts() async {
    try {
      final response = await _dioClient.get(getGifts);
      //print('$response mygifts22222222');
      if (response['gifts'] != null && (response['gifts'] as List).isNotEmpty) {
        return (response['gifts'] as List)
            .map<Gift>((item) => Gift.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> useGifts(String giftId, String userId, int points) async {
    try {
      final response = await _dioClient.post(useGift,
          data: {"userid": userId, "giftid": giftId, "points": points});
      print('$response mygiftssss');
      if (response['userTransaction'] != null &&
          response['userTransaction']['points'] == points) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Adding send points to another phone number
}
