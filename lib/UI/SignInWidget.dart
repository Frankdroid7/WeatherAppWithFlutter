import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:weather_app/Provider/UserProvider.dart';
import 'package:weather_app/UI/HomeWidget.dart';

import '../main.dart';

class SignInWidget extends StatefulWidget {
  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  bool _showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Sign In',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24.0,
            ),
          ),
          SizedBox(height: 5.0),
          SizedBox(height: 30.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: SizedBox(
              height: 50.0,
              child: RaisedButton(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/google_icon.png'),
                    SizedBox(width: 10.0),
                    Text(
                      'Login with Google',
                      style:
                          TextStyle(fontSize: 16.0, color: Color(0XFFB5B5B5)),
                    ),
                  ],
                ),
                onPressed: () {
                  setState(() {
                    _showSpinner = true;
                  });
                  _signInWithGoogle().whenComplete(() async {
                    setState(() {
                      _showSpinner = false;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeWidget()),
                    );
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

String firstNameFromGoogle = '';
String lastNameFromGoogle = '';

Future _signInWithGoogle() async {
  UserProvider userModel = UserProvider();
  final googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;

  /*To split FirstName and LastName. They usually come
  together like "Franklin Oladipo".
  */
  List<String> displayName = user.displayName.split(' ');
  firstNameFromGoogle = displayName[0];
  lastNameFromGoogle = displayName[1];
  userModel.setFirstName(firstNameFromGoogle);
}

Future signOutGoogle() async {
  await googleSignIn.signOut();
}
