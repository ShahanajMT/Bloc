import 'dart:convert';
import 'dart:developer';

import 'package:bloc_api/Features/post/models/post_model.dart';
import 'package:http/http.dart' as http;

class PostRepo {
   static Future <List<PostModel>> fetchPost () async {
    var client = http.Client();
    List<PostModel> posts = [];
    try {
      var response = await client.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts/'),
      );

      List results = jsonDecode(response.body);

      for (int i = 0; i < results.length; i++) {
        PostModel post = PostModel.fromJson(results[i] as Map<String, dynamic>);
        posts.add(post);
      }

      return posts;

     // print(posts);
    }
    catch (e) {
      log(e.toString());
      return [];
    }
  }
}