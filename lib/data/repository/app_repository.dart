
import '../model/post_model.dart';
import '../source/data_souce.dart';

abstract class AppRepository {
  /// C
  Future<void> createPost({required PostModel post});

  /// R
  Future<List<PostModel>> getAllPosts();

  /// U
  Future<void> updatePosts({required PostModel post});

  /// D
  Future<void> deletePosts({required String id});
}

class AppRepositoryImpl implements AppRepository {
  final Network network;
  const AppRepositoryImpl({required this.network});

  @override
  Future<void> createPost({required PostModel post}) async {
    await network.post(api: Api.apiPost, body: post.toJson());
  }

  @override
  Future<List<PostModel>> getAllPosts() async {
    final res = await network.get(api: Api.apiPost) as List;
    return res
        .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> updatePosts({required PostModel post}) async {
    await network.put(
        api: Api.apiPost, body: post.toJson(), id: post.id.toString());
  }

  @override
  Future<void> deletePosts({required String id}) async {
    await network.delete(api: Api.apiPost, id: id);
  }
}
