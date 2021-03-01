import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_blog/simple_blog.dart';

class EditCommentPage extends StatefulWidget {
  final Comment comment;

  const EditCommentPage({Key key, this.comment}) : super(key: key);

  @override
  _EditCommentPageState createState() => _EditCommentPageState();
}

class _EditCommentPageState extends State<EditCommentPage> {
  final _formKey = GlobalKey<FormFieldState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  _submitPost() async {
    if (_formKey.currentState.validate()) {
      BlocProvider.of<CommentBloc>(context).add(
        EditComment(
          comment: _formKey.currentState.value,
          id: widget.comment.id,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CommentBloc, CommentState>(
      listener: (context, state) {
        if (state.status == CommentStatus.editingError) {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(
              'An error occured saving your blog. Please try again.',
            ),
          ));
        } else if (state.status == CommentStatus.edited) {
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 11.0,
                      vertical: 12,
                    ),
                    child: BlocBuilder<CommentBloc, CommentState>(
                      builder: (context, state) {
                        return FlatButton(
                          onPressed: state.status == CommentStatus.editing
                              ? null
                              : _submitPost,
                          disabledColor: Color(0x99E9446A),
                          child: state.status == CommentStatus.editing
                              ? SizedBox(
                                  height: 12,
                                  width: 12,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation(
                                      Theme.of(context).backgroundColor,
                                    ),
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
                  initialValue: widget.comment.content,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                      hintText: "What's Happening?", border: InputBorder.none),
                  validator: (text) =>
                      text.isEmpty ? "Comment can't be empty" : null,
                ),
              ),
            ),
          )),
    );
  }
}
