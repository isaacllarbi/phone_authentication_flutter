import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_authentication_flutter/enter_code_screen.dart';
import 'package:phone_authentication_flutter/phone_auth_screen.dart';

class EnterNumberScreen extends StatefulWidget {
  @override
  _EnterNumberScreenState createState() => _EnterNumberScreenState();
}

class _EnterNumberScreenState extends State<EnterNumberScreen> {
  final prefixCtrl = TextEditingController(text: '+233');
  final numberCtrl = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    prefixCtrl.dispose();
    numberCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildCard(),
              SizedBox(height: 10),
              Text(
                'Verify Your Number',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 22,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 5),
              buildText(),
              SizedBox(height: 30),
              buildForm(),
              SizedBox(height: 30),
              buildContainer(context),
              // buildFlatButton(),
            ],
          ),
        ),
      ),
    );
  }

  Card buildCard() {
    return Card(
      child: Container(
        child: Center(
          child: Icon(Icons.phone_android, size: 150, color: Colors.white),
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
      'Please enter your mobile number to recieve a verification code. Carrier rates may apply',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: Colors.black38,
      ),
    );
  }

  Form buildForm() {
    return Form(
      key: formKey,
      child: ListTile(
        leading: SizedBox(
          width: 60,
          child: TextFormField(
            controller: prefixCtrl,
            maxLength: 4,
            decoration: InputDecoration(
                hintText: '+233', hintStyle: TextStyle(color: Colors.black26)),
            keyboardType: TextInputType.phone,
            validator: (value) {
              var prefixes = ['+233'];
              if (value.isEmpty) {
                return 'Invalid';
              }
              return null;
            },
          ),
        ),
        title: TextFormField(
          controller: numberCtrl,
          decoration: InputDecoration(
              hintText: '054 251 4205',
              hintStyle: TextStyle(color: Colors.black26)),
          maxLength: 10,
          keyboardType: TextInputType.number,
          validator: (value) {
            var prefixes = ['+233'];
            if (value.isEmpty || value.length < 9 || value.length > 10) {
              return 'Please enter a valid number';
            }
            return null;
          },
        ),
      ),
    );
  }

  Container buildContainer(BuildContext context) {
    return Container(
      width: 250,
      height: 50,
      child: RaisedButton(
        onPressed: () async {
          if (formKey.currentState.validate()) {
            print(prefixCtrl.text + numberCtrl.text);
            try {
              await FirebaseAuth.instance.verifyPhoneNumber(
                  phoneNumber: prefixCtrl.text + numberCtrl.text,
                  timeout: Duration(seconds: 60),
                  verificationCompleted: (credential) {
                    print('onVerificationCompleted');
                    FirebaseAuth.instance.signInWithCredential(credential);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (ctx) => PhoneAuthScreen(),
                      ),
                    );
                  },
                  verificationFailed: (exception) {
                    print('onVerificationFailed: ' + exception.toString());
                  },
                  codeSent: (verId, [forceResend]) {
                    print('onCodeSent');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EnterCodeScreen(verId: verId),
                      ),
                    );
                  },
                  codeAutoRetrievalTimeout: null);
            } catch (e) {
              print(e.toString());
            }
          }
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

  FlatButton buildFlatButton() {
    return FlatButton(
      onPressed: () {},
      child: Text('NO, OTHER TIME'),
      splashColor: Colors.red.shade300,
    );
  }
}
