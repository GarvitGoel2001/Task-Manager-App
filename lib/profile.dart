import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'package:sizer/sizer.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var _myFormKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  late String email, password, displayname;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 5,
          margin: EdgeInsets.only(top: 10, bottom: 5),
        ),
        fixTextFieldOutlineLabel: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Container(),
          title: Text('Create Account',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontStyle: FontStyle.normal,
                  fontFamily: 'Uchen',
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2)),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.transparent,
          child: ListView(
            padding: EdgeInsets.all(20),
            shrinkWrap: false,
            scrollDirection: Axis.vertical,
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Stack(fit: StackFit.loose, children: [
                      CircleAvatar(
                        radius: 70.sp,
                        backgroundImage:
                            NetworkImage("https://picsum.photos/200/300"),
                      )
                    ]),
                    SizedBox(
                      height: 3.h,
                    ),
                    Form(















                      
                      key: _myFormKey,
                      child: Column(
                        children: [
                          Card(
                            borderOnForeground: true,
                            child: ListTile(
                              title: TextFormField(
                                textInputAction: TextInputAction.next,
                                onChanged: (value) {
                                  displayname =
                                      value; //get the value entered by user.
                                },
                                //controller: _displayNameController,
                                keyboardType: TextInputType.name,
                                validator: (String? msg) {
                                  if (msg!.isEmpty) {
                                    return " Please Enter Name";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    hintText: 'Enter Name ',
                                    prefixIcon: Container(
                                      margin: EdgeInsets.all(7),
                                      padding: EdgeInsets.symmetric(),
                                      decoration: BoxDecoration(
                                          color: Colors.blue.shade400,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Icon(
                                        Icons.person_outline_rounded,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    )),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Card(
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            child: ListTile(
                              title: TextFormField(
                                //controller: _emailController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.emailAddress,
                                validator: (String? msg) {
                                  if (msg!.isEmpty) {
                                    return " Please Enter Email";
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  email =
                                      value; //get the value entered by user.
                                },
                                decoration: InputDecoration(
                                    hintText: 'Enter Email',
                                    prefixIcon: Container(
                                        margin: EdgeInsets.all(7),
                                        padding: EdgeInsets.symmetric(),
                                        decoration: BoxDecoration(
                                            color: Colors.blue.shade400,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: Icon(
                                          Icons.email_rounded,
                                          color: Colors.white,
                                          size: 20,
                                        ))),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Card(
                            borderOnForeground: true,
                            child: ListTile(
                              title: TextFormField(
                                // controller: _passwordController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.visiblePassword,
                                onChanged: (value) {
                                  password =
                                      value; //get the value entered by user.
                                },
                                validator: (String? msg) {
                                  if (msg!.isEmpty) {
                                    return " Please Enter Password";
                                  }
                                  return null;
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'Enter Password',
                                  prefixIcon: Container(
                                    margin: EdgeInsets.all(7),
                                    padding: EdgeInsets.symmetric(),
                                    decoration: BoxDecoration(
                                        color: Colors.blue.shade400,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Icon(
                                      Icons.person_add_alt,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4.h),
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
                              fontSize: 20,
                              fontFamily: 'Open Sans',
                            ),
                            elevation: 5.0,
                            shadowColor: Colors.black,
                            visualDensity: VisualDensity.comfortable),
                        onPressed: () async {
                          if (_myFormKey.currentState?.validate() == true) {
                            try {
                              var credential =
                                  await _auth.createUserWithEmailAndPassword(
                                      email: email, password: password);
                              await credential.user!
                                  .updateDisplayName(displayname);
                              FirebaseFirestore.instance
                                  .collection("Users")
                                  .add({
                                "Email Id": email,
                                "Password": password,
                                "Name": displayname
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Signin()),
                              );
                            } catch (e) {
                              print(e);
                              final snackbar =
                                  SnackBar(content: Text(e.toString()));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackbar);
                            }
                          }
                        },
                        child: Text('Sign Up'),
                      ),
                    ),
                    SizedBox(height: 1.5.h),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text('Already have an account?'),
                      InkWell(
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, color: Colors.red),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Signin()));
                          })
                    ])
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}
