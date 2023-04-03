import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ResetPass extends StatefulWidget {
  @override
  _ResetPassState createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  var _myformkey = GlobalKey<FormState>();
  late String email;
  final auth = FirebaseAuth.instance;

  final snackBar =
      SnackBar(content: Text('A Reset code has been sent at your email Id'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.black, size: 18.sp)),
        title: Text(
          'Back',
          style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black,
              fontFamily: 'sans-serif',
              fontStyle: FontStyle.normal),
        ),
        titleSpacing: -1,
      ),
      body: Padding(
        padding: EdgeInsets.all(0.5.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Padding(
                  padding: EdgeInsets.only(top: 3.h),
                  child: Text('Reset Password',
                      style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'sans-serif')),
                ),
              ]),
              Container(
                padding: EdgeInsets.only(right: 15.w, top: 1.h),
                child: Text(
                  'Enter the email associated with your account'
                  ' and we will send you an email with instructions'
                  ' to reset your password.',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.normal,
                    fontFamily: 'sans-serif',
                  ),
                ),
              ),
              Center(
                child: Image(
                  image: AssetImage('assets/resetpass.png'),
                  height: 30.h,
                  width: 90.w,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Email ID',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      )),
                ],
              ),
              Form(
                key: _myformkey,
                child: SizedBox(
                  width: 97.w,
                  child: TextFormField(
                    validator: (String? msg) {
                      if (msg!.isEmpty) {
                        return 'Enter verified email';
                      }
                    },
                    onChanged: (value) {
                      email = value; // get value from TextField
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: 'Enter Username or Email Address',
                        border: OutlineInputBorder()),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5.h),
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  autofocus: false,
                  style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30.w, vertical: 2.h),
                      primary: Colors.blue.shade800,
                      onPrimary: Colors.white,
                      onSurface: Colors.grey,
                      textStyle: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: 'Open Sans',
                      ),
                      elevation: 5.0,
                      shadowColor: Colors.black,
                      visualDensity: VisualDensity.comfortable),
                  onPressed: () {
                    if (_myformkey.currentState?.validate() == true) {
                      auth.sendPasswordResetEmail(email: email);
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Send Request'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
