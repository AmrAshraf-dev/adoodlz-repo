import 'dart:math';

import 'package:adoodlz/blocs/models/post.dart';
import 'package:adoodlz/data/remote/constants/endpoints.dart';
import 'package:adoodlz/data/remote/dio_client.dart';
import 'package:adoodlz/data/remote/interfaces/i_posts_api.dart';

class PostsApi implements IPostsApi {
  final DioClient _dioClient;
  //final _random = new Random();
  PostsApi(this._dioClient);

  @override
  Future<List<Post>> fetchPosts() async {
    print('this base url in fetch $baseUrl');
    try {
      final response = await _dioClient.get(getPosts);
      if (response['posts'] != null && (response['posts'] as List).isNotEmpty) {
        return (response['posts'] as List)
            .map<Post>((item) => Post.fromJson(item as Map<String, dynamic>))
            .where((v) => v.status.toLowerCase() == 'active')
            .toList();
        //var element = list[_random.nextInt(list.length)];

      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Post>> fetchPostsWithFilters(
      {DateTime fromDate, DateTime toDate, String tag}) {
    // TODO: implement fetchPostsWithFilters
    throw UnimplementedError();
  }
}
