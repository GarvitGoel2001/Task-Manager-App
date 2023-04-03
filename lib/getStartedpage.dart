import 'login.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';

class GettinStarted extends StatefulWidget {
  const GettinStarted({Key? key}) : super(key: key);

  @override
  _GettinStartedState createState() => _GettinStartedState();
}

class _GettinStartedState extends State<GettinStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          Text(
            'Task Manager',
            style: TextStyle(
                fontSize: 30.sp,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
                fontFamily: 'Uchen'),
          ),
          SizedBox(
            height: 7.h,
          ),
          Center(
            child: Image(
              image: AssetImage('assets/todo vector.png'),
              height: 40.h,
              width: 40.h,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
            child: Text(
              'Organise your work in an efficient manner and save your precious time with this application',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(
            height: 7.h,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              autofocus: false,
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.w)),
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
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Signin()),
                );
              },
              child: Text('Get Started'),
            ),
          ),
        ],
      ),
    );
  }
}
