import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_blog/simple_blog.dart';
import 'package:simple_blog/src/data/comment/bloc/comment_bloc.dart';
import 'package:simple_blog/src/data/comment/model/model.dart';
import 'package:simple_blog/src/data/comment/repository/repository.dart';
import 'package:simple_blog/src/dependency_injection/injector.dart';
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
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormFieldState>();
  final _textController = TextEditingController();

  bool editing = false;
  Post get post => widget.post;

  bool isEditing = false;
  Comment commentToEdit;

  String comment = '';

  @override
  Widget build(BuildContext context) {
    print('${widget.post.id} senay post id');
    final _width = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) =>
          getIt<CommentBloc>()..add(ReadComments(widget.post.id)),
      child: Scaffold(
        // key: _scaffoldKey,
        bottomNavigationBar: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: TextFormField(
            initialValue: comment,
            onChanged: (val) {
              comment = val;
            },
            validator: (text) => text.isEmpty ? "Comment can't be empty" : null,
            key: _formKey,
            decoration: InputDecoration(
              suffixIcon: BlocBuilder<CommentBloc, CommentState>(
                builder: (context, state) {
                  return IconButton(
                    onPressed:
                        state.createStatus == CreateCommentStatus.creating
                            ? null
                            : () async {
                                if (!isEditing) {
                                  print('${comment} bura');
                                  BlocProvider.of<CommentBloc>(context).add(
                                    CommenToPost(
                                      CommentPayload(
                                        comment: comment,
                                        postId: widget.post.id,
                                      ),
                                    ),
                                  );
                                } else {
                                  BlocProvider.of<CommentBloc>(context).add(
                                    EditComments(
                                        comment: comment,
                                        commentId: commentToEdit.id),
                                  );
                                }
                              },
                    icon: Icon(
                      Icons.send,
                      color: Theme.of(context).primaryColor,
                    ),
                  );
                },
              ),
              border: OutlineInputBorder(),
              hintText: 'enter your comment...',
            ),
          ),
        ),
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
        body: SingleChildScrollView(
          child: Container(
            color: Theme.of(context).backgroundColor,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
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
                                    fit: BoxFit.cover,
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
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  BlocBuilder<CommentBloc, CommentState>(
                    builder: (context, state) {
                      print('${state.comments} naba');

                      if (state.comments != null) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.comments.length,
                          itemBuilder: (context, index) {
                            print('${state.comments} naba');

                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.red,
                              ),
                              title: Text(state.comments[index].user.name),
                              subtitle: Text(state.comments[index].content ??
                                  'null comment'),
                              trailing: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () async {
                                        BlocProvider.of<CommentBloc>(context)
                                            .add(DeleteComments(
                                                state.comments[index].id));
                                      },
                                      icon: Icon(Icons.delete)),
                                  TextButton(
                                    onPressed: () {
                                      isEditing = true;
                                      // setState(() {
                                      //   comment = state.comments[index].content;
                                      // });
                                      commentToEdit = state.comments[index];
                                    },
                                    child: Text(
                                      'Edit',
                                      style:
                                          TextStyle(color: Colors.blueAccent),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
