import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phone_authentication_flutter/enter_code_screen.dart';
import 'package:phone_authentication_flutter/enter_number_screen.dart';
import 'package:phone_authentication_flutter/phone_auth_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Phone Auth',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.redAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // fontFamily: GoogleFonts.lato().fontFamily,
        textTheme: GoogleFonts.nunitoSansTextTheme()
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (ctx, snapshot) =>
            snapshot.hasData ? PhoneAuthScreen() : EnterNumberScreen(),
      ),
    );
  }
}
