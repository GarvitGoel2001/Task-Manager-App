
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'login.dart';
import 'newtask.dart';
import 'updateTask.dart';
import 'package:sizer/sizer.dart';

class MyTasks extends StatefulWidget {
  const MyTasks({Key? key}) : super(key: key);

  @override
  _MyTasksState createState() => _MyTasksState();
}

class _MyTasksState extends State<MyTasks> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
      .collection("Users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('Tasks')
      .snapshots();

  DateTime today = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[600],
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            Expanded(
                flex: 1,
                child: Container(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
                      trailing: IconButton(
                          onPressed: () async {
                            await _auth.signOut();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Signin()));
                          },
                          icon: Icon(
                            Icons.logout_rounded,
                            size: 18.sp,
                            color: Colors.red,
                          )),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueAccent[600],
                        backgroundImage: AssetImage('assets/smile.jpg'),
                      ),
                      title: Text(
                        "All Tasks ",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 26.sp),
                      ),
                    ),
                  ],
                ))),
            Expanded(
                flex: 3,
                child: Container(
                    height: 58.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50))),
                    child: StreamBuilder<QuerySnapshot>(
                        stream: _stream,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                Map<String, dynamic> task =
                                    snapshot.data!.docs[index].data()
                                        as Map<String, dynamic>;

                                return Slidable(
                                  actionPane: SlidableDrawerActionPane(),
                                  actionExtentRatio: 0.2.sp,
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 4.w, vertical: 1.4.h),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.03),
                                              offset: Offset(0, 9),
                                              blurRadius: 20,
                                              spreadRadius: 1)
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(10.sp)),
                                    child: ListTile(
                                      onTap: () {
                                        _bottomsheet(context, task);
                                      },
                                      leading: Icon(
                                        Icons.circle,
                                        color: Colors.tealAccent[200],
                                      ),
                                      title: Text(
                                        task["Title"],
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      ),
                                      subtitle: Text(task["Schedule Time"]),
                                      trailing: Text(DateFormat.yMMMd().format(
                                          DateTime.parse(task['Schedule Date']
                                              .toDate()
                                              .toString()))),
                                    ),
                                  ),
                                  secondaryActions: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 1.4.h),
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.03),
                                                offset: Offset(0, 9),
                                                blurRadius: 20,
                                                spreadRadius: 1)
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(10.sp)),
                                      child: IconSlideAction(
                                        caption: "Edit",
                                        color: Colors.green,
                                        icon: Icons.edit,
                                        onTap: () async {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => UpdateTask(
                                                  task: task,
                                                  id: snapshot
                                                      .data!.docs[index].id),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 1.4.h),
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.03),
                                                offset: Offset(0, 9),
                                                blurRadius: 20,
                                                spreadRadius: 1)
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(10.sp)),
                                      child: IconSlideAction(
                                        caption: "Delete",
                                        color: Colors.red,
                                        icon: Icons.delete,
                                        onTap: () async {
                                          FirebaseFirestore.instance
                                              .collection("Users")
                                              .doc(FirebaseAuth
                                                  .instance.currentUser!.uid)
                                              .collection("Tasks")
                                              .doc(
                                                  snapshot.data!.docs[index].id)
                                              .delete();
                                        },
                                      ),
                                    )
                                  ],
                                );
                              });
                        })))
          ]),
        ),
        floatingActionButton: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.sp), color: Colors.blue),
          child: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => NewTask()));
            },
            icon: Icon(
              Icons.add,
              size: 16.sp,
            ),
          ),
        ));
  }

//to display bottom scrollable sheet containing details of task
  void _bottomsheet(BuildContext context, task) {
    showModalBottomSheet(
        backgroundColor: Colors.green[200],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.w), topRight: Radius.circular(12.w)),
        ),
        context: context,
        builder: (BuildContext c) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(5.w),
              child: Column(
                children: [
                  Row(children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black87,
                        size: 16.sp,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ]),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  Row(
                    children: [
                      Text(
                        'Title:',
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        task["Title"],
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                            fontSize: 16.sp),
                      ),
                    ],
                  ),
                  Divider(thickness: 0.5),
                  Row(
                    children: [
                      Text(
                        'Description:',
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        task['Description'],
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                            fontSize: 16.sp),
                      ),
                    ],
                  ),
                  Divider(thickness: 0.5),
                  Row(
                    children: [
                      Text(
                        'DeadLine:',
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        DateFormat.yMMMd().format(DateTime.parse(
                            task['Deadline Date'].toDate().toString())),
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                            fontSize: 16.sp),
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        task["Deadline Time"],
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                            fontSize: 16.sp),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
