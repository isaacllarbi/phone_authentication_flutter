import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_authentication_flutter/enter_code_screen.dart';
import 'package:phone_authentication_flutter/enter_number_screen.dart';

class PhoneAuthScreen extends StatefulWidget {
  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  bool codeSent = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Text('Welcome to BuyBulk'),
            SizedBox(height: 30),
            RaisedButton(
              child: Text('Log out'),
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
            )
            // Expanded(
            //   child: codeSent ? EnterCodeScreen() : EnterNumberScreen(),
            // ),
            // buildButton(),
          ],
        ),
      ),
    );
  }

  buildButton() {
    return Container(
      width: 250,
      height: 50,
      child: RaisedButton(
        onPressed: () {
          // if (formKey.currentState.validate()) {
          //   Navigator.push(context,
          //       MaterialPageRoute(builder: (context) => EnterCodeScreen()));
          // }
          setState(() {
            codeSent = !codeSent;
          });
        },
        child: Text(
          'CONTINUE',
          style: TextStyle(color: Colors.white),
        ),
        splashColor: Colors.red,
        color: Colors.red.shade300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
          side: BorderSide(color: Colors.red.shade300),
        ),
      ),
    );
  }
}
