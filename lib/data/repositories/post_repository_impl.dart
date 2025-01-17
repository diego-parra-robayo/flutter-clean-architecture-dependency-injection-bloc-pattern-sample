import 'package:apitest/data/datasources/remote/post/post_remote.dart';
import 'package:apitest/domain/entities/post.dart';
import 'package:apitest/domain/repositories/post_repository.dart';
import 'package:async/async.dart';

class PostRepositoryImpl implements PostRepository {
  PostRepositoryImpl({required this.remoteDataSource});

  final PostRemote remoteDataSource;

  @override
  Future<Result<List<Post>>> getPosts() {
    return Result.capture(remoteDataSource.getPosts());
  }

  @override
  Future<Result<Post>> getPost(int id) {
    return Result.capture(remoteDataSource.getPost(id));
  }
}
