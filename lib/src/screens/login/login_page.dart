import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatelessWidget {
  static String routeName = '/login';
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // final AuthenticationBloc authenticationBloc =

    void _handleSubmitted() {
      if (_formKey.currentState.validate()) {
        // String _phone = _formKey.currentState.value;
        // _phone = _phone.startsWith('0') ? _phone.substring(1) : _phone;

      }
    }

    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        color: Theme.of(context).backgroundColor,
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            Expanded(
              child: Column(
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
                        style: DefaultTextStyle.of(context).style,
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
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        // validator: (value) => validatePhone(value),
                        // onFieldSubmitted: (_) => _handleSubmitted(),
                        // enabled: state is! SignInLoadingState,
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

                          keyboardType: TextInputType.visiblePassword,

                          // validator: (value) => validatePhone(value),
                          // onFieldSubmitted: (_) => _handleSubmitted(),
                          // enabled: state is! SignInLoadingState,
                          decoration: InputDecoration(
                            labelText: 'Password',
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
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                          color:
                                              Theme.of(context).backgroundColor,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            onPressed: null,
                            disabledColor: Color(0x99E9446A),
                          ),
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Already have an account?  ',
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
                                ..onTap = () => print(
                                      'Tap from ',
                                    ),
                            ),
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
    );
  }
}
