import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_blog/simple_blog.dart';
import 'package:simple_blog/src/dependency_injection/injector.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:cached_network_image/cached_network_image.dart';

class Feed extends StatelessWidget {
  static final String routeName = '/';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Simple Blog',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).accentColor,
          ),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () => Navigator.of(context).pushNamed(Profile.routeName),
          ),
        ],
      ),
      body: BlocBuilder<FeedBloc, FeedState>(builder: (context, state) {
        if (state.feedStatus == FeedStatus.initial) {
          BlocProvider.of<FeedBloc>(context).add(
            ReadFeed(),
          );
          return Container(
            color: Theme.of(context).backgroundColor,
            child: Center(
              child: SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (state.feedStatus == FeedStatus.loading) {
          return Container(
            color: Theme.of(context).backgroundColor,
            child: Center(
              child: SizedBox(
                  width: 40, height: 40, child: CircularProgressIndicator()),
            ),
          );
        } else if (state.feedStatus == FeedStatus.loaded ||
            state.feedStatus == FeedStatus.created) {
          return Container(
            color: Theme.of(context).backgroundColor,
            child: state.feed.isEmpty
                ? RefreshIndicator(
                    onRefresh: () async {
                      BlocProvider.of<FeedBloc>(context).add(
                        ReloadFeed(),
                      );
                      return Future.delayed(Duration(seconds: 1));
                    },
                    child: ListView(
                      // shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      children: [
                        Container(
                          color: Theme.of(context).backgroundColor,
                          height: MediaQuery.of(context).size.height -
                              Scaffold.of(context).appBarMaxHeight,
                          child: Center(
                            child: Text(
                              'No blogs at the moment',
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      BlocProvider.of<FeedBloc>(context).add(
                        ReloadFeed(),
                      );
                      return Future.delayed(Duration(seconds: 1));
                    },
                    child: ListView.builder(
                      itemCount: state.feed.length,
                      itemBuilder: (context, index) {
                        if (index == state.feed.length - 2) {
                          BlocProvider.of<FeedBloc>(context).add(
                            ReadNextPageFeed(),
                          );
                        }
                        return _Blog(
                          post: state.feed[index],
                        );
                      },
                    ),
                  ),
          );
        } else if (state.feedStatus == FeedStatus.loadingError) {
          return Container(
            color: Theme.of(context).backgroundColor,
            child: Center(
              child: TryAgainButton(
                onPressed: () => BlocProvider.of<FeedBloc>(context).add(
                  ReadFeed(),
                ),
              ),
            ),
          );
        }
        return Container(
          color: Theme.of(context).backgroundColor,
          child: Center(
            child: SizedBox(
                width: 40, height: 40, child: CircularProgressIndicator()),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                      value: BlocProvider.of<FeedBloc>(context),
                      child: CreateBlog(),
                    )),
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}

class TryAgainButton extends StatelessWidget {
  final VoidCallback onPressed;
  const TryAgainButton({
    Key key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Failed to load feed',
          style: TextStyle(
            fontSize: 15.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: FlatButton(
            color: Theme.of(context).primaryColor,
            textColor: Theme.of(context).backgroundColor,
            onPressed: onPressed,
            child: Text('Try again'),
          ),
        ),
      ],
    );
  }
}

class _Blog extends StatelessWidget {
  final Post post;

  _Blog({@required this.post});
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider<CommentBloc>(
              create: (_) => getIt<CommentBloc>(),
              child: BlocProvider.value(
                value: BlocProvider.of<FeedBloc>(context),
                child: Blog(
                  post: post,
                ),
              ),
            ),
          ),
        );
      },
      child: Column(
        children: [
          SizedBox(
            width: _width,
            height: _width * 10 / 16,
            child: Image.network(
              // 'assets/images/logo.png',
              '${post.image}',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 17,
                            backgroundImage: CachedNetworkImageProvider(
                              post.user.profilePic,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${post.user.name}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 2.0),
                                  child: RichText(
                                    text: TextSpan(
                                      style: DefaultTextStyle.of(context).style,
                                      children: [
                                        TextSpan(
                                          text: "@${post.user.username}  ",
                                          style: TextStyle(
                                            color: Theme.of(context).hintColor,
                                            fontSize: 12.0,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              '${timeago.format(post.createdAt)}',
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Theme.of(context).hintColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    '${post.caption}',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
