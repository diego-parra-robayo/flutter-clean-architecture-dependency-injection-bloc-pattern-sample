import 'package:apitest/injection_container.dart' as di;
import 'package:apitest/core/widgets/error_message_with_retry.dart';
import 'package:apitest/l10n/l10n.dart';
import 'package:apitest/presentation/home/bloc/home_bloc.dart';
import 'package:apitest/presentation/home/view/post_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsList extends StatelessWidget {
  const PostsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
        create: (context) => di.injector.get<HomeBloc>()..add(FetchPostsHomeEvent()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return CircularProgressIndicator(
              semanticsLabel: context.l10n.loading,
            );
          } else if (state is HomeFailure) {
            return ErrorMessageWithRetry(
                message: state.message,
                onRetryPressed: (context) => context.read<HomeBloc>().add(FetchPostsHomeEvent()),
            );
          } else if (state is HomeSuccess) {
            return state.posts.isEmpty
                ? Text(context.l10n.no_posts)
                : ListView.builder(
              itemCount: state.posts.length,
                itemBuilder: (context, index) => PostListTile(post: state.posts[index])
            );
          } else {
            return ErrorMessageWithRetry(
                message: context.l10n.unable_to_fetch_posts,
                onRetryPressed: (context) => context.read<HomeBloc>().add(FetchPostsHomeEvent()),
            );
          }
        },
      ),
    );
  }
}
