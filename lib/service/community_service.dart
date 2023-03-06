import '../model/network_result.dart';
import '../model/post.dart';
import '../network/dio_client.dart';

class CommunityService {
  static final CommunityService _communityService =
      CommunityService._internal();
  factory CommunityService() {
    return _communityService;
  }
  CommunityService._internal();

  Future<List<Post>> getPost() async {
    var response =
        await DioClient().get('http://localhost:3000/counselors', {});
    if (response.result == Result.success) {
      var posts = response.response['posts'];
      return posts.map((post) => Post.fromJson(post)).toList();
    } else {
      throw Exception('Failed to load counselors');
    }
  }
}
