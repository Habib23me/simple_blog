import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_blog/simple_blog.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:cached_network_image/cached_network_image.dart';

class Blog extends StatefulWidget {
  final Post post;

  const Blog({Key key, this.post}) : super(key: key);
  // static final String routeName = '/blog';

  @override
  _BlogState createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormFieldState>();

  bool editing = false;
  Post get post => widget.post;

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    void _handleSubmit({bool edit, String id}) {
      if (_formKey.currentState.validate()) {
        if (edit != null && edit) {
          BlocProvider.of<CommentBloc>(context).add(
            EditComment(
              id: id,
              comment: _formKey.currentState.value,
            ),
          );
        }
        BlocProvider.of<CommentBloc>(context).add(
          CreateComment(
            comment: _formKey.currentState.value,
            postId: post.id,
          ),
        );
      }
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        leading: BackButton(
          color: Theme.of(context).accentColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocListener<CommentBloc, CommentState>(
        listener: (context, state) {
          if (state.status == CommentStatus.creatingError) {
            _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text(
                  'An error occured saving your comment.Please try again.',
                ),
              ),
            );
          } else if (state.status == CommentStatus.created) {
            _formKey.currentState.reset();
          } else if (state.status == CommentStatus.deletingError) {
            _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text(
                  'An error occured deleting your comment.Please try again.',
                ),
              ),
            );
          }
        },
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(bottom: 60),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: _width,
                          height: _width * 10 / 16,
                          child: Image.network(
                            '${post.image}',
                            fit: BoxFit.fill,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Text(
                              "${post.caption}",
                              style: TextStyle(
                                fontSize: 16,
                                height: 1.5,
                                color: Theme.of(context).accentColor,
                                // decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                        ),
                        BlocBuilder<CommentBloc, CommentState>(
                          builder: (context, state) {
                            if (state.status == CommentStatus.intial) {
                              BlocProvider.of<CommentBloc>(context).add(
                                ReadComments(post.id),
                              );
                            } else if (state.status == CommentStatus.loaded ||
                                state.status == CommentStatus.created ||
                                state.status == CommentStatus.edited ||
                                state.status == CommentStatus.deleted) {
                              return ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: state.comments.length,
                                itemBuilder: (context, index) {
                                  if (index == state.comments.length - 2) {
                                    BlocProvider.of<CommentBloc>(context).add(
                                      ReadNextComments(widget.post.id),
                                    );
                                  }
                                  return _Comment(
                                    comment: state.comments[index],
                                  );
                                },
                              );
                            } else if (state.status == CommentStatus.loading ||
                                state.status == CommentStatus.editingError) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return Container();
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 60,
                  color: Theme.of(context).backgroundColor,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 24.0, right: 12),
                          child: TextFormField(
                            key: _formKey,
                            validator: (text) =>
                                text.isEmpty ? "Comment can't be empty" : null,
                            textInputAction: TextInputAction.newline,
                            keyboardType: TextInputType.multiline,
                            minLines: null,
                            maxLines:
                                null, // If this is null, there is no limit to the number of lines, and the text container will start with enough vertical space for one line and automatically grow to accommodate additional lines as they are entered.
                            expands: true,
                            decoration: InputDecoration(
                              // labelText: 'Comment',
                              hintText: 'Comment',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      BlocBuilder<CommentBloc, CommentState>(
                        builder: (context, state) {
                          return IconButton(
                              icon: Icon(
                                Icons.send,
                                color: Theme.of(context).primaryColor,
                              ),
                              onPressed: state.status == CommentStatus.creating
                                  ? null
                                  : _handleSubmit);
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Comment extends StatelessWidget {
  final Comment comment;
  _Comment({@required this.comment});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: CircleAvatar(
                        radius: 17,
                        backgroundImage: CachedNetworkImageProvider(
                          '${comment.user.profilePic}',
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "${comment.user.username}  ",
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              '${timeago.format(comment.createdAt)}',
                                          style: TextStyle(
                                            fontSize: 10.0,
                                            color: Theme.of(context).hintColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                PopupMenuButton(
                                  onSelected: (value) {
                                    if (value == 'Edit') {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(builder: (_) {
                                        return BlocProvider.value(
                                          value: BlocProvider.of<CommentBloc>(
                                              context),
                                          child:
                                              EditCommentPage(comment: comment),
                                        );
                                      }));
                                    } else {
                                      BlocProvider.of<CommentBloc>(context).add(
                                        DeleteComment(comment.id),
                                      );
                                    }
                                  },
                                  itemBuilder: (BuildContext context) => [
                                    PopupMenuItem(
                                      value: 'Edit',
                                      child: Text('Edit'),
                                    ),
                                    PopupMenuItem(
                                      value: 'Delete',
                                      child: Text('Delete'),
                                    ),
                                  ],
                                ),
                              ],
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
          Padding(
            padding: EdgeInsets.only(top: 2.0),
            child: Text(
              '${comment.content}',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
