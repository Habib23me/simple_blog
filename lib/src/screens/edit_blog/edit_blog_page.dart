import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_blog/simple_blog.dart';

class EditBlog extends StatefulWidget {
  final Post post;

  const EditBlog({Key key, this.post}) : super(key: key);

  @override
  _EditBlogState createState() => _EditBlogState();
}

class _EditBlogState extends State<EditBlog> {
  final _formKey = GlobalKey<FormFieldState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  _submitPost() async {
    if (_formKey.currentState.validate()) {
      BlocProvider.of<UserPostsBloc>(context).add(
        EditUserPost(
          postId: widget.post.id,
          caption: _formKey.currentState.value,
        ),
      );
    }
  }

  _deletePost() async {
    if (_formKey.currentState.validate()) {
      BlocProvider.of<UserPostsBloc>(context).add(
        DeleteUserPost(widget.post.id),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserPostsBloc, UserPostsState>(
      listener: (context, state) {
        if (state.status == UserPostsStatus.editingError) {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(
              'An error occured saving your blog. Please try again.',
            ),
          ));
        } else if (state.status == UserPostsStatus.deletingError) {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(
              'An error occured deleting your blog. Please try again.',
            ),
          ));
        } else if (state.status == UserPostsStatus.edited||state.status==UserPostsStatus.deleted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
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
            actions: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BlocBuilder<UserPostsBloc, UserPostsState>(
                    builder: (context, state) {
                      return IconButton(
                          onPressed: state.status == UserPostsStatus.deleting
                              ? null
                              : _deletePost,
                          disabledColor: Color(0x99E9446A),
                          icon: state.status == UserPostsStatus.deleting
                              ? SizedBox(
                                  height: 12,
                                  width: 12,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : Icon(
                                  Icons.delete,
                                ));
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 11.0,
                      vertical: 12,
                    ),
                    child: BlocBuilder<UserPostsBloc, UserPostsState>(
                      builder: (context, state) {
                        return FlatButton(
                          onPressed: state.status == UserPostsStatus.editing
                              ? null
                              : _submitPost,
                          disabledColor: Color(0x99E9446A),
                          child: state.status == UserPostsStatus.editing
                              ? SizedBox(
                                  height: 12,
                                  width: 12,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation(
                                        Theme.of(context).backgroundColor),
                                  ),
                                )
                              : Text('Save'),
                          color: Theme.of(context).primaryColor,
                          textColor: Theme.of(context).backgroundColor,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          body: Container(
            color: Theme.of(context).backgroundColor,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Container(
                child: TextFormField(
                  key: _formKey,
                  expands: true,
                  maxLines: null,
                  initialValue: widget.post.caption,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                      hintText: "What's Happening?", border: InputBorder.none),
                  validator: (text) =>
                      text.isEmpty ? "Caption can't be empty" : null,
                ),
              ),
            ),
          )),
    );
  }
}
