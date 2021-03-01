import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_blog/simple_blog.dart';
import 'package:timeago/timeago.dart' as timeago;

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
            icon: CircleAvatar(
              radius: 17,
              backgroundImage: AssetImage(
                'assets/images/logo.png',
              ),
            ),
            onPressed: null,
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
                  width: 40, height: 40, child: CircularProgressIndicator()),
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
                    onRefresh: () {
                      BlocProvider.of<FeedBloc>(context).add(
                        ReloadFeed(),
                      );
                      return;
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
                    onRefresh: () {
                      BlocProvider.of<FeedBloc>(context).add(
                        ReadFeed(),
                      );
                      return;
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
              child: Column(
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
                      onPressed: () {
                        BlocProvider.of<FeedBloc>(context).add(
                          ReadFeed(),
                        );
                      },
                      child: Text('Try again'),
                    ),
                  ),
                ],
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
          Navigator.pushNamed(context, CreateBlog.routeName);
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}

class _Blog extends StatelessWidget {
  Post post;

  _Blog({@required this.post});
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Blog.routeName,
          arguments: post,
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
                            backgroundImage: AssetImage(
                              'assets/images/logo.png',
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
