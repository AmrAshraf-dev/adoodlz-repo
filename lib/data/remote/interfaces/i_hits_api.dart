import 'package:adoodlz/blocs/models/hit.dart';

abstract class IHitsApi {
  Future<bool> recordHit(Hit hit, {String affiliaterId});
}
