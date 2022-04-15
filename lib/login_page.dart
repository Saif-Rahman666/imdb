import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:imdb/src/ui/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> googleSignIn() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if(googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      UserCredential userCredential = await auth.signInWithCredential(authCredential);
      User? user = userCredential.user;

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const HomeScreen())
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
      color: Colors.white,
        height: 400.0,
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () {
            googleSignIn();
          },
  
                   child: new Column(
                        children: [
                            new Container(
                                height: 200,
                                width: 200,
                                decoration: new BoxDecoration(
                                    image: DecorationImage(
                                        image: new AssetImage('/Users/saifrahman/Downloads/imdb/imdb/assets/images/google.png'),
                                        fit: BoxFit.fill
                                    ),
                                    shape: BoxShape.circle
                                ),
                            ),
                            new Container(
                                child: new Text('Sign in with Google',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'Aleo',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25.0,
                                        color: Colors.black
                                      
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
