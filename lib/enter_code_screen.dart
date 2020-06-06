import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_authentication_flutter/phone_auth_screen.dart';

class EnterCodeScreen extends StatefulWidget {
  final String verId;

  const EnterCodeScreen({Key key, @required this.verId}) : super(key: key);

  @override
  _EnterCodeScreenState createState() => _EnterCodeScreenState();
}

class _EnterCodeScreenState extends State<EnterCodeScreen> {
  final formKey = GlobalKey<FormState>();
  final codeCtrl = TextEditingController();
  String error='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildCard(),
                SizedBox(height: 20),
                buildText(),
                SizedBox(height: 40),
                buildForm(),
                SizedBox(height: 15),
                Text(error),
                SizedBox(height: 15),
                buildFlatButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Card buildCard() {
    return Card(
      child: Container(
        child: Center(
          child: Icon(
            Icons.phone_android,
            size: 150,
            color: Colors.white,
          ),
        ),
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blue, Colors.red]),
        ),
      ),
      elevation: 10.0,
      shape: CircleBorder(),
      clipBehavior: Clip.antiAlias,
    );
  }

  Text buildText() {
    return Text(
      'A one time code has been sent to you on your mobile phone. Please enter it below.',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: Colors.black45,
      ),
    );
  }

  Form buildForm() {
    return Form(
      key: formKey,
      child: TextFormField(
        controller: codeCtrl,
        style: TextStyle(letterSpacing: 38),
        maxLength: 6,
        cursorColor: Colors.black45,
        showCursor: false,
        keyboardType: TextInputType.phone,
        validator: (value) {
          if (value.length != 6) {
            return 'Code must be 6 digits';
          }
          return null;
        },
      ),
    );
  }

  FlatButton buildFlatButton() {
    return FlatButton(
      onPressed: () async {
        if (formKey.currentState.validate()) {
          // formKey.currentState
          print('code: ${codeCtrl.text}\n verificationId: ${widget.verId}');

          try {
            AuthCredential credential = PhoneAuthProvider.getCredential(
              verificationId: widget.verId,
              smsCode: codeCtrl.text,
            );
            await FirebaseAuth.instance.signInWithCredential(credential);
            Navigator.of(context).pop();
          } catch (e) {
            print(e.toString());
            setState(() {
              error=e.message.toString();
            });
          }
        }
      },
      child: Text('VERIFY'),
      splashColor: Colors.red.shade300,
    );
  }
}
