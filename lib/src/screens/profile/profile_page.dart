import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_blog/simple_blog.dart';
import 'package:simple_blog/src/data/user/bloc/user_bloc.dart';
import 'package:simple_blog/src/dependency_injection/injector.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'widget/profile_post.dart';

class Profile extends StatelessWidget {
  static const routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UserBloc>(),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state.status == UserStatus.intial) {
            BlocProvider.of<UserBloc>(context).add(GetUserEvent());
          }

          if (state.status == UserStatus.error) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0.5,
              ),
              body: IconButton(
                onPressed: () =>
                    BlocProvider.of<UserBloc>(context).add(GetUserEvent()),
                icon: Icon(
                  Icons.refresh,
                ),
              ),
            );
          }
          if (state.status == UserStatus.loaded) {
            return _ProfilePage(
              user: state.user,
            );
          }
          return Scaffold(
            appBar: AppBar(
              elevation: 0.5,
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}

class _ProfilePage extends StatelessWidget {
  final User user;

  const _ProfilePage({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UserPostsBloc>(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 1.0,
          title: Text("${user.name}"),
          actions: [
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
                BlocProvider.of<AuthenticationBloc>(context).add(
                  AuthenticationEvent.unAuthenticate,
                );
              },
            ),
          ],
        ),
        body: Container(
          color: Theme.of(context).backgroundColor,
          child: Builder(
            builder: (context) => RefreshIndicator(
              onRefresh: () async => BlocProvider.of<UserPostsBloc>(context)
                  .add(ReloadUserPosts()),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 24.0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    CachedNetworkImageProvider(user.profilePic),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                              child: Text(
                                '@${user.username}',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    BlocBuilder<UserPostsBloc, UserPostsState>(
                        builder: (context, state) {
                      if (state.status == UserPostsStatus.initial) {
                        BlocProvider.of<UserPostsBloc>(context)
                            .add(ReadUserPosts());
                      }
                      if (state.status == UserPostsStatus.loadingError) {
                        return Center(
                          child: TryAgainButton(
                            onPressed: () =>
                                BlocProvider.of<UserPostsBloc>(context)
                                    .add(ReadUserPosts()),
                          ),
                        );
                      }

                      if (state.status == UserPostsStatus.loaded ||
                          state.status == UserPostsStatus.edited ||
                          state.status == UserPostsStatus.deleted) {
                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.posts.length,
                          itemBuilder: (_, int index) {
                            if (index == state.posts.length - 2) {
                              BlocProvider.of<UserPostsBloc>(context).add(
                                ReadNextUserPosts(),
                              );
                            }
                            return ProfilePost(post: state.posts[index]);
                          },
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
