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
      body: Container(
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
      ),
    );
  }
}
