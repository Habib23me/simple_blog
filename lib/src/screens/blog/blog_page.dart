import 'package:flutter/material.dart';
import 'package:simple_blog/simple_blog.dart';

class Blog extends StatelessWidget {
  static String routeName = '/blog';
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
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
          child: Stack(alignment: Alignment.bottomCenter, children: [
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(bottom: 60),
                child: Column(
                  children: [
                    Container(
                      width: _width,
                      height: _width * 10 / 16,
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      child: Text(
                        'Tempor proident labore excepteur ex labore esse occaecat veniam. Irure anim deserunt nulla fugiat ea Lorem exercitation est labore laboris consequat quis anim. Culpa reprehenderit commodo magna mollit. Aute cillum nostrud consequat consectetur fugiat.Tempor proident labore excepteur ex labore esse occaecat veniam. Irure anim deserunt nulla fugiat ea Lorem exercitation est labore laboris consequat quis anim. Culpa reprehenderit commodo magna mollit. Aute cillum nostrud consequat consectetur fugiat.',
                        style: TextStyle(
                          fontSize: 17,
                          color: Theme.of(context).accentColor,
                          // decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                    _Comment(),
                    _Comment(),
                    _Comment(),
                    _Comment(),
                    _Comment(),
                    _Comment(),
                    _Comment(),
                  ],
                ),
              ),
            ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  height: 60,
                  color: Theme.of(context).backgroundColor,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
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
                      IconButton(
                          icon: Icon(
                            Icons.send,
                            color: Theme.of(context).primaryColor,
                          ),
                          onPressed: null)
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ));
  }
}

class _Comment extends StatelessWidget {
  Comment comment;
  _Comment({@required this.comment});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Column(
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
                        backgroundImage: AssetImage(
                          'assets/images/logo.png',
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
                                      style: DefaultTextStyle.of(context).style,
                                      children: [
                                        TextSpan(
                                          text: "@username ",
                                          style: TextStyle(
                                            color: Theme.of(context).hintColor,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'just now',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Theme.of(context).hintColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                PopupMenuButton(
                                  // onSelected: (WhyFarther result) { setState(() { _selection = result; }); },
                                  itemBuilder: (BuildContext context) => [
                                    PopupMenuItem(
                                      value: 'a',
                                      child: Text('Edit'),
                                    ),
                                    PopupMenuItem(
                                      value: 'a',
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
              'Sit eiusmod aliquip nisi id eiusmod nulla. Aliqua amet commodo et ut Lorem velit do. Laborum labore veniam dolore irure ex Lorem. ',
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
