import 'package:flutter/material.dart';
import 'package:playonn_user/core/screens/signin.dart';
import 'package:playonn_user/core/services/email_auth.dart';
import 'package:playonn_user/core/services/google_sign_in.dart';
import 'package:playonn_user/core/shared/imagebuttons.dart';
import 'package:email_validator/email_validator.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String _name = '';
  String _email = '';
  String _password = '';

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(children: <Widget>[
        SizedBox(
          height: 40.0,
        ),
        Container(
            padding: EdgeInsets.only(top: 30.0, left: 30),
            child: Text('Create\n Account',
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold))),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Form(
            key: _formkey,
            child: Column(children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Container(
                height: 50.0,
                child: TextFormField(
                  validator: (name) {
                    if (name.isEmpty) return 'please provide a valid username';
                  },
                  onSaved: (name) {
                    _name = name;
                    print(_name);
                  },
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Name',
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                height: 50.0,
                child: TextFormField(
                  validator: (val) => !EmailValidator.validate(val, true)
                      ? 'Not a valid email.'
                      : null,
                  // validator: (email) {
                  //   var validEmail = RegExp(
                  //           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  //       .hasMatch(email);

                  // if (validEmail) return 'please provide a valid email';

                  onSaved: (email) {
                    _email = email;
                    print(_email);
                  },
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                height: 50.0,
                child: TextFormField(
                  validator: (password) {
                    // RegExp regExp = RegExp(
                    //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                    // var validPassword = regExp.hasMatch(password);
                    if (password.length <= 6)
                      return 'please provide a strong password';
                    // else
                    //   return 'please provide a valid password';
                  },
                  controller: passwordController,
                  onSaved: (password) {
                    _password = password;
                  },
                  decoration: InputDecoration(
                    hintText: 'password',
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
            ]),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          height: 150,
          child: Row(
            children: <Widget>[
              Container(
                child: RaisedButton(
                  color: Colors.white,
                  elevation: 0.0,
                  child: Text('Sign up',
                      style: TextStyle(
                        fontSize: 25.0, fontWeight: FontWeight.w600,
                        // decoration: TextDecoration.underline
                      )),
                  onPressed: () {
                    print('Sign up Pressed');
                    signUpWithEmailIdAndPassword(
                        _formkey, _email, _password, context);
                  },
                ),
              ),
              SizedBox(
                width: 120.0,
              ),
              FloatingActionButton(
                  backgroundColor: Colors.black54,
                  child: Icon(Icons.keyboard_arrow_right),
                  onPressed: () {}),
            ],
          ),
        ),
        //
        //
        Container(
            // color: Colors.transparent,
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 160,
                  child: GestureDetector(
                    child: Text('Sign in',
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline)),
                    onTap: () {
                      print('Sign in Pressed');

                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Signin()));
                    },
                  ),
                ),
                Expanded(
                    child: imageButton('facebook.png', () {
                  print('Facebook');
                })),
                Expanded(
                    child: imageButton('google.png', () {
                  print('Google');
                  googleSignInMethod(context);
                }))
              ],
            ))
      ]),
    );
  }
}
