import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_blog/simple_blog.dart';
import 'package:simple_blog/src/data/account/bloc/sign_in/sign_in_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_blog/src/data/account/bloc/sign_up/sign_up_bloc.dart';
import 'package:simple_blog/src/dependency_injection/injector.dart';

class Login extends StatelessWidget {
  static String routeName = '/login';
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onSubmit(BuildContext context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      var payload = Provider.of<SignInPayload>(context, listen: false);
      BlocProvider.of<SignInBloc>(context).add(SignInEvent(payload));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is SignedInState) {
            BlocProvider.of<AuthenticationBloc>(context)
                .add(AuthenticationEvent.authenticate);
          } else if (state is ErrorSignInState) {
            _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text("${state.message}"),
              ),
            );
          }
        },
        child: Scaffold(
          key: _scaffoldKey,
          body: Container(
            color: Theme.of(context).backgroundColor,
            padding: EdgeInsets.only(
              left: 50,
              right: 50,
              top: kToolbarHeight + 50,
            ),
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.asset('assets/images/logo.png')),
                    Padding(
                      padding: const EdgeInsets.only(top: 48.0),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Welcome to',
                              style: TextStyle(
                                color: Theme.of(context).hintColor,
                                fontSize: 22.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: ' Simple Blog',
                              style: TextStyle(
                                fontSize: 22.0,
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            validator: Validators.emailValidator,
                            onSaved: (data) => Provider.of<SignInPayload>(
                                    context,
                                    listen: false)
                                .email = data,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                color: Theme.of(context).hintColor,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: TextFormField(
                              obscureText: true,
                              obscuringCharacter: '*',
                              validator: Validators.isNotEmpty,
                              keyboardType: TextInputType.visiblePassword,
                              onSaved: (data) => Provider.of<SignInPayload>(
                                context,
                                listen: false,
                              ).password = data,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                errorMaxLines: 2,
                                labelStyle: TextStyle(
                                  color: Theme.of(context).hintColor,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 48.0,
                            ),
                            child: Container(
                              width: double.infinity,
                              child: FlatButton(
                                color: Theme.of(context).primaryColor,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14.0,
                                  ),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: Center(
                                          child: BlocBuilder<SignInBloc,
                                              SignInState>(
                                            builder: (context, state) {
                                              if (state is SigningInState) {
                                                return SizedBox(
                                                  height: 30,
                                                  width: 30,
                                                  child:
                                                      CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                            Color>(
                                                      Colors.white,
                                                    ),
                                                  ),
                                                );
                                              }
                                              return Text(
                                                "Login",
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .backgroundColor,
                                                  fontSize: 18,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                onPressed: () => _onSubmit(context),
                                disabledColor: Color(0x99E9446A),
                              ),
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Don't have an account yet? ",
                                  style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontSize: 14.0,
                                  ),
                                ),
                                TextSpan(
                                    text: 'Signup',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 14.0,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return BlocProvider<
                                                  SignUpBloc>.value(
                                                value: getIt<SignUpBloc>(),
                                                child: ChangeNotifierProvider
                                                    .value(
                                                  value: SignUpPayload(),
                                                  child: SignUp(),
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      }),
                              ],
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
        ));
  }
}
