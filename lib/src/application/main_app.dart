import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_blog/simple_blog.dart';
import 'package:simple_blog/src/dependency_injection/injector.dart';

import '../src.dart';

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<FeedBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<AuthenticationBloc>(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Color(0xFFE9446A),
          accentColor: Color(0xFF0E0E0E),
          hintColor: Color(0xFF9B9B9B),
          backgroundColor: Colors.white,
          fontFamily: 'Roboto',
        ),
        routes: {
          CreateBlog.routeName: (context) => CreateBlog(),
          Feed.routeName: (context) => Feed(),
          Blog.routeName: (context) => BlocProvider(
                create: (context) => getIt<CommentBloc>(),
                child: Blog(),
              )
        },
        initialRoute: Feed.routeName,
        // home: Splash(),
      ),
    );
  }
}
