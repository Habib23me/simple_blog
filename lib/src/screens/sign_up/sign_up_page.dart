import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_blog/simple_blog.dart';
import 'package:provider/provider.dart';
import 'package:simple_blog/src/data/account/bloc/sign_in/sign_in_bloc.dart';
import 'package:simple_blog/src/data/account/bloc/sign_up/sign_up_bloc.dart';

class SignUp extends StatelessWidget {
  static String routeName = '/signUp';
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _submit(BuildContext context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      var payload = Provider.of<SignUpPayload>(context, listen: false);
      BlocProvider.of<SignUpBloc>(context).add(SignUpEvent(payload));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (_, state) {
        if (state is SignedUpState) {
          Navigator.of(context).popUntil((route) => route.isFirst);
          BlocProvider.of<AuthenticationBloc>(context)
              .add(AuthenticationEvent.authenticate);
        } else if (state is ErrorSignUpState) {
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text("${state.message}"),
            ),
          );
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0.0,
        ),
        body: Container(
          color: Theme.of(context).backgroundColor,
          padding: EdgeInsets.only(
            left: 50,
            right: 50,
            top: kToolbarHeight - 42,
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
                          keyboardType: TextInputType.name,
                          validator: Validators.isNotEmpty,
                          onSaved: (data) =>
                              Provider.of<SignUpPayload>(context, listen: false)
                                  .name = data,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            labelStyle: TextStyle(
                              color: Theme.of(context).hintColor,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            validator: Validators.emailValidator,
                            onSaved: (data) => Provider.of<SignUpPayload>(
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
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: TextFormField(
                            obscureText: true,
                            obscuringCharacter: '*',
                            keyboardType: TextInputType.visiblePassword,
                            onSaved: (data) => Provider.of<SignUpPayload>(
                                    context,
                                    listen: false)
                                .password = data,
                            validator: Validators.passwordValidator,
                            // onFieldSubmitted: (_) => _handleSubmitted(),
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
                                child: BlocBuilder<SignUpBloc, SignUpState>(
                                  builder: (context, state) {
                                    if (state is SigningUpState) {
                                      return SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            Colors.white,
                                          ),
                                        ),
                                      );
                                    }
                                    return Center(
                                      child: Text(
                                        "Sign up",
                                        style: TextStyle(
                                          color:
                                              Theme.of(context).backgroundColor,
                                          fontSize: 18,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              onPressed: () => _submit(context),
                              disabledColor: Color(0x99E9446A),
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
      ),
    );
  }
}
