import 'package:adoodlz/blocs/models/post.dart';

abstract class IPostsApi {
  Future<List<Post>> fetchPosts();
  Future<List<Post>> fetchPostsWithFilters({DateTime fromDate, DateTime toDate, String tag});
}
