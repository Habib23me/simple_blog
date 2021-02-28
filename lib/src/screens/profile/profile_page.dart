import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: _width,
                height: 250,
                child: Stack(children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 18.0),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(
                              'assets/images/logo.png',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Name Name',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            '@username',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'name@email.com',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 5,
                    top: 15,
                    child: TextButton(
                      onPressed: null,
                      child: Text(
                        'Edit',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                ]),
              ),

              Container(
                // flex: 2,
                child: Container(
                  child: Column(
                    children: [
                      SingleFeedProfile(),
                      SingleFeedProfile(),
                      SingleFeedProfile(),
                      SingleFeedProfile(),
                      SingleFeedProfile(),
                      SingleFeedProfile(),
                      SingleFeedProfile(),
                      SingleFeedProfile(),
                    ],
                  ),
                ),
              ),
              // ListView.builder(
              //   itemCount: 10,
              //   itemBuilder: (BuildContext context, int i) {
              //     return Container();
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class SingleFeedProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
          width: _width,
          height: _width * 10 / 16,
          child: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  'Minim deserunt est proident ipsum. Culpa Lorem adipisicing ad nostrud nisi aliqua et. Incididunt ex consectetur ea laborum commodo duis excepteur veniam proident irure in.',
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
    );
  }
}
