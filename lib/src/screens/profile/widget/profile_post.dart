import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_blog/simple_blog.dart';

class ProfilePost extends StatelessWidget {
  final Post post;

  const ProfilePost({Key key, this.post}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: BlocProvider.of<UserPostsBloc>(context),
              child: EditBlog(post: post),
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: _width,
            height: _width * 10 / 16,
            child: Image.network(
              '${post.image}',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 18.0,
              vertical: 8.0,
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 16.0),
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
