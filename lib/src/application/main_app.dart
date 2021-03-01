import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_blog/simple_blog.dart';
import 'package:simple_blog/src/data/account/bloc/sign_in/sign_in_bloc.dart';
import 'package:simple_blog/src/dependency_injection/injector.dart';
import 'package:simple_blog/src/screens/splash/splash_page.dart';
import 'package:provider/provider.dart';
import '../src.dart';

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
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
          appBarTheme: AppBarTheme(
            brightness: Brightness.light,
            color: Colors.white,
            elevation: 1.0,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            textTheme: TextTheme(
                headline6: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            )),
          ),
        ),
        routes: {
          Profile.routeName: (context) => Profile(),
        },

        home: BlocBuilder<AuthenticationBloc, AuthenticationStatus>(
          builder: (context, state) {
            if (state == AuthenticationStatus.unauthenticated) {
              return BlocProvider(
                  create: (context) => getIt<SignInBloc>(),
                  child: ChangeNotifierProvider.value(
                    value: SignInPayload(),
                    child: Login(),
                  ));
            }
            if (state == AuthenticationStatus.authenticated) {
              return BlocProvider(
                create: (context) => getIt<FeedBloc>(),
                child: Feed(),
              );
            }
            BlocProvider.of<AuthenticationBloc>(context)
                .add(AuthenticationEvent.getAuthState);
            return Splash();
          },
        ),

        // home: Splash(),
      ),
    );
  }
}
