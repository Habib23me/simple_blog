import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_blog/simple_blog.dart';

class CreateBlog extends StatefulWidget {
  static String routeName = '/blog/create';

  @override
  _CreateBlogState createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  final picker = ImagePicker();

  final _formKey = GlobalKey<FormFieldState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  File _image = new File('');

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    PickedFile pickedImage;
    Future _pickImage() async {
      try {
        pickedImage = await picker.getImage(source: ImageSource.gallery);
        setState(() {
          _image = File(pickedImage.path);
        });
      } catch (e) {}
    }

    _submitPost() async {
      if (_formKey.currentState.validate()) {
        final bool _exists = await _image.exists();
        if (_exists) {
          BlocProvider.of<FeedBloc>(context).add(
            PostToFeed(
              PostPayload(
                image: _image,
                caption: _formKey.currentState.value,
              ),
            ),
          );
        } else {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(
              'Please select an image',
            ),
          ));
        }
      }
    }

    return BlocListener<FeedBloc, FeedState>(
      listener: (context, state) {
        if (state.feedStatus == FeedStatus.creatingError) {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(
              'An error occured saving your blog. Please try again.',
            ),
          ));
        } else if (state.feedStatus == FeedStatus.created) {
          Navigator.pop(context);
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
                  child: BlocBuilder<FeedBloc, FeedState>(
                    builder: (context, state) {
                      return FlatButton(
                        onPressed: state.feedStatus == FeedStatus.creating
                            ? null
                            : _submitPost,
                        disabledColor: Color(0x99E9446A),
                        child: state.feedStatus == FeedStatus.creating
                            ? SizedBox(
                                height: 12,
                                width: 12,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation(
                                      Theme.of(context).backgroundColor),
                                ),
                              )
                            : Text('Post'),
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
            child: Column(
              children: [
                Container(
                  width: _width,
                  height: _width * 10 / 16,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: _image.existsSync()
                      ? InkWell(
                          child: Image.file(
                            _image,
                            fit: BoxFit.fill,
                          ),
                          onTap: () async {
                            await _pickImage();
                          },
                        )
                      : Center(
                          child: IconButton(
                            icon: Icon(
                              Icons.camera_alt,
                              color: Theme.of(context).primaryColor,
                            ),
                            onPressed: () async {
                              await _pickImage();
                            },
                          ),
                        ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 18),
                    child: Container(
                      child: TextFormField(
                        key: _formKey,
                        expands: true,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            hintText: "What's Happening?",
                            border: InputBorder.none),
                        validator: (text) =>
                            text.isEmpty ? "Caption can't be empty" : null,
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
