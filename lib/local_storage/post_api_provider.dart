import 'dart:convert';

import 'package:adoodlz/blocs/models/post.dart';
import 'package:dio/dio.dart';
import 'package:adoodlz/local_storage/db_providers.dart';

class PostApiProvider {
  Future<List<Post>> getAllPosts() async {
    const url = "http://api.adoodlz.com/posts";
    final Response response = await Dio().get(url);

    return (response.data as List).map((post) {
      print('Inserting $post');
      //  DBProvider.db.createPost(Post.fromJson(post));
    }).toList();
  }
}
