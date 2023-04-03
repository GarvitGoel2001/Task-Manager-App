import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'getStartedpage.dart';
import 'todo.dart';
import 'resetpass.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'profile.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _auth = FirebaseAuth.instance;
  late String email, password;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => GettinStarted()));
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 18.sp,
            ),
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.all(0.5.h),
          child: Stack(
            children: [
              Image(
                image: AssetImage('assets/footerpic.jpg'),
                height: 100.h,
                width: 100.w,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 3.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 2.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome Back!!',
                          style: TextStyle(
                              fontSize: 24.sp, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 2.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Sign in to continue...',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: 'sans-serif',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  ListTile(
                    title: TextFormField(
                      enableSuggestions: true,
                      keyboardType: TextInputType.emailAddress,
                      validator: (String? msg) {
                        if (msg!.isEmpty) {
                          return " Please Enter Email";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        email = value; // get value from TextField
                      },
                      decoration: InputDecoration(
                          hintText: 'Enter Email',
                          prefixIcon: Container(
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.symmetric(),
                              decoration: BoxDecoration(
                                  color: Colors.blue.shade600,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Icon(
                                Icons.email_rounded,
                                color: Colors.white,
                                size: 18.sp,
                              ))),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  ListTile(
                    title: TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      validator: (String? msg) {
                        if (msg!.isEmpty) {
                          return " Please Enter Password";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        password = value; // get value from TextField
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Enter Password',
                        prefixIcon: Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.symmetric(),
                          decoration: BoxDecoration(
                              color: Colors.blue.shade600,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Icon(
                            Icons.person_add_alt,
                            color: Colors.white,
                            size: 18.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Padding(
                    padding: EdgeInsets.only(right: 5.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                            onTap: () {
                              debugPrint('Reset password');
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => ResetPass()),
                              );
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'sans-serif',
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal),
                            ))
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      autofocus: false,
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.w, vertical: 2.h),
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
                      onPressed: () async {
                        try {
                          final newUser =
                              await _auth.signInWithEmailAndPassword(
                                  email: email, password: password);
                          print(newUser.toString());
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MyTasks()));
                        } catch (e) {
                          print(e);
                          final snackbar =
                              SnackBar(content: Text(e.toString()));
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        }
                      },
                      child: Text('Sign In'),
                    ),
                  ),
                  Divider(
                    color: Colors.transparent,
                    thickness: 1,
                  ),
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueGrey,
                        fontFamily: 'sans-serif'),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 2.h),
                    child: ElevatedButton(
                      autofocus: false,
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blueGrey[50],
                          onPrimary: Colors.transparent,
                          onSurface: Colors.white,
                          textStyle: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: 'Open Sans',
                          ),
                          elevation: 2.0,
                          shadowColor: Colors.black,
                          visualDensity: VisualDensity.comfortable),
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Profile()));
                      },
                      child: Text(
                        'Register Now!',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
