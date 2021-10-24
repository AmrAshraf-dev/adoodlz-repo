import 'dart:convert';
import 'dart:io';
import 'package:adoodlz/blocs/models/post.dart';
import 'package:adoodlz/blocs/models/user.dart';
import 'package:adoodlz/data/remote/interfaces/i_posts_api.dart';
import 'package:crypto/crypto.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

class PostsProvider extends ChangeNotifier {
  final IPostsApi _postsApi;
  List<Post> posts;
  bool _loading;
  User user = User();
  Post _post = Post();
  // final authProvider = Provider.of<AuthProvider>(
  //    listen: false
  // );
  bool get loading => _loading;

  set loading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  PostsProvider(this._postsApi) : _loading = false;

  Future<File> _getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load(path);

    final file = File('${(await getTemporaryDirectory()).path}/image.png');
    print(file.toString());
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  Future<List<Post>> getPosts() async {
    try {
      loading = true;
      // ignore: join_return_with_assignment
      posts = await _postsApi.fetchPosts();
      posts.shuffle();
      return posts;
    } catch (e) {
      rethrow;
    } finally {
      loading = false;
    }
  }

  Future<void> sharePostData(Post post, int userId) async {
    //final shareUrl = 'http://pin.adoodlz.com/?p=${post.id}&u=$userId';
    final String timeStamp = await getTimeStamp(post, userId);
    final shareUrl =
        'http://pin.adoodlz.com/?p=${post.id}&u=$userId&r=$timeStamp';

    final imageFile = await getCachedImageFile(post.media.first) ??
        await _getImageFileFromAssets('assets/images/logo.png');
    //imageFile ??= await getImageFileFromAssets('assets/images/logo.png');
    final imagePath = imageFile.path.split('/');
    imagePath.removeLast();
    final newImageFile =
        await imageFile.copy('${imagePath.join('/')}/ad-image.jpg');
    final path = newImageFile.path;
    await Share.shareFiles([path],
        subject: '${post.title}:  $shareUrl \n ${post.content}',
        text: '${post.title}:  $shareUrl \n ${post.content}');
    //imagePath:'${post.media}:  $shareUrl \n ${post.content}';
    newImageFile.delete();
  }

  /// the current time, in “milliseconds since the epoch”
  static int currentTimeInSeconds() {
    //var ms = (new DateTime.now()).millisecondsSinceEpoch;
    final int ms = DateTime.now().day;
    //(ms / 1000).round();
    final int lastnums = ms % 1000;
    return lastnums;
  }

  // ignore: missing_return
  Future<int> currentTimeInDay(Post post, int userId) async {
    return 0;
  }

  Future<String> getTimeStamp(Post post, int userId) async {
    final int timeStampDay =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
            .millisecondsSinceEpoch;
    // ignore: avoid_print
    print(userId);
    // ignore: avoid_print
    print(post.id);
    // ignore: avoid_print
    print(timeStampDay);
    //print((timeStampHere/1000).round());
    final int hashKey = userId + (post.id) + timeStampDay;
    // ignore: avoid_print
    print('this our Hash key $hashKey');
    final bytes1 = utf8.encode(hashKey.toString()); // data being hashed
    final String hashValue =
        sha256.convert(bytes1).toString(); // Hashing Process
    //print("Digest as bytes: ${digest1.bytes}"); // Print Bytes
    // ignore: avoid_print
    print("Digest as hex string: $hashValue"); // Print After Hashing
    String indexesArray = userId.toString();
    while (indexesArray.length < 5) {
      // ignore: use_string_buffers
      indexesArray += userId.toString();
    }
    final String todayHashPart = hashValue[int.parse(indexesArray[0])] +
        hashValue[int.parse(indexesArray[1])] +
        hashValue[int.parse(indexesArray[2])] +
        hashValue[int.parse(indexesArray[3])] +
        hashValue[int.parse(indexesArray[4])];
    // ignore: avoid_print
    print(' hashPart = $todayHashPart');
    // ignore: avoid_print
    print('index array = $indexesArray');
    return todayHashPart;
  }

  /// the current time, in “seconds since the epoch”
// static int currentTimeInSeconds() {
//     var ms = (new DateTime.now()).millisecondsSinceEpoch;
//     return (ms / 1000).round();
// }

}

// Future<String> getR(Post post, int userId) async {
//   final int timeStampDay =
//       DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
//           .millisecondsSinceEpoch;
//   final int hashKey = userId + (post.id) + timeStampDay;
//   print(userId);
//   print(post.id);
//   print(timeStampDay);
//   print('this our Hash key $hashKey');

//   var bytes1 = utf8.encode(hashKey.toString()); // data being hashed
//   String digest1 = sha256.convert(bytes1).toString(); // Hashing Process
//   print("Digest as hex string: $digest1");

//   String indexArray = userId.toString();
//   while (indexArray.length < 5) {
//     // ignore: use_string_buffers
//     indexArray += userId.toString();
//   }

//   final String r = digest1[int.parse(indexArray[0])] +
//       digest1[int.parse(indexArray[1])] +
//       digest1[int.parse(indexArray[2])] +
//       digest1[int.parse(indexArray[3])] +
//       digest1[int.parse(indexArray[4])];

//   print('this our R $r');
//   print('indexx $indexArray');

//   return r;
// }
