import 'package:intl/intl.dart' as intl;

String getTimeTillExpire(DateTime expireTime) {
  if (DateTime.now().isBefore(expireTime)) {
    final difference = expireTime.difference(DateTime.now());
    if (difference.inDays > 0) {
      return '${difference.inDays} days';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} h';
    } else {
      return '${difference.inMinutes} m';
    }
  } else {
    return 'Expired';
  }
}

bool isRTL(String text) {
  return intl.Bidi.detectRtlDirectionality(text);
}
