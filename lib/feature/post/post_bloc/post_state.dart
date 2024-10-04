part of 'post_bloc.dart';

@immutable
sealed class PostState {
  final List<PostModel> postList;
  const PostState({required this.postList});
}

final class PostInitial extends PostState {
  PostInitial() : super(postList: <PostModel>[]);
}

final class PostLoading extends PostState {
  const PostLoading({required super.postList});
}

final class PostLoaded extends PostState {
  final String? message;
  const PostLoaded({required super.postList, this.message});
}

final class PostError extends PostState {
  final String errorText;
  const PostError({required super.postList, required this.errorText});
}
