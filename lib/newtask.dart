import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NewTask extends StatefulWidget {
  @override
  State createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  TimeOfDay selectedTime = TimeOfDay.now();
  TimeOfDay selectedTimedead = TimeOfDay.now();
  DateTime selectedDate = DateTime.now();
  DateTime selectedDatedead = DateTime.now();

  var _myFormKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _textEditingController1 = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _timeController1 = TextEditingController();
  var myFormat = DateFormat.yMd();

  Future<Null> _selectDate(BuildContext context) async {
    var picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _textEditingController.text = myFormat.format(selectedDate);
      });
  }

  var _hour, _minute, _time, _timed;
  Future<void> _selectedTime(BuildContext context) async {
    var picker = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picker != null)
      setState(() {
        selectedTime = picker;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();

        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
      });
  }

  Future<Null> _selectDateDead(BuildContext context) async {
    var picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: selectedDate,
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDatedead = picked;
        _textEditingController1.text = myFormat.format(selectedDatedead);
      });
  }

  Future<void> _selectTimeDead(BuildContext context) async {
    var picker = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picker != null)
      setState(() {
        selectedTime = picker;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();

        _timed = _hour + ' : ' + _minute;

        _timeController1.text = _timed;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(8.h),
        child: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                size: 18.sp,
              )),
          title: Text('New Task',
              style: TextStyle(
                fontSize: 24.sp,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              )),
          centerTitle: true,
        ),
      ),
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: SingleChildScrollView(
          child: Form(
            key: _myFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: Text('Task Title',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      )),
                ),
                ListTile(
                  title: SizedBox(
                    child: TextFormField(
                      validator: (String? msg) {
                        if (msg!.isEmpty) {
                          return " Please Enter Title";
                        }
                        return null;
                      },
                      controller: _titleController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        hintText: 'Enter Title of Task',
                      ),
                    ),
                  ),
                ),
                ListTile(
                  leading: Text(
                    'Schedule',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4.w, right: 4.w),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextFormField(
                            validator: (String? msg) {
                              if (msg!.isEmpty) {
                                return " Please Enter Date";
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            controller: _textEditingController,
                            onTap: () {
                              _selectDate(context);
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                hintText: 'Date'),
                          ),
                        ),
                        Icon(Icons.compare_arrows),
                        Expanded(
                          child: TextFormField(
                            validator: (String? msg) {
                              if (msg!.isEmpty) {
                                return " Please Enter Time";
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            controller: _timeController,
                            onTap: () {
                              _selectedTime(context);
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                hintText: 'Time'),
                          ),
                        ),
                      ]),
                ),
                ListTile(
                  leading: Text(
                    'Deadline',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4.w, right: 4.w),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextFormField(
                            validator: (String? msg) {
                              if (msg!.isEmpty) {
                                return " Please Enter Deadline date";
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            controller: _textEditingController1,
                            onTap: () {
                              _selectDateDead(context);
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                hintText: 'Date'),
                          ),
                        ),
                        Icon(Icons.compare_arrows),
                        Expanded(
                          child: TextFormField(
                            validator: (String? msg) {
                              if (msg!.isEmpty) {
                                return " Please Enter Deadline time";
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            controller: _timeController1,
                            onTap: () {
                              _selectTimeDead(context);
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                hintText: 'Time'),
                          ),
                        ),
                      ]),
                ),
                ListTile(
                  leading: Text('Description',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      )),
                ),
                ListTile(
                  title: SizedBox(
                    height: 15.h,
                    child: TextFormField(
                      validator: (String? msg) {
                        if (msg!.isEmpty) {
                          return " Please Enter Description";
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.done,
                      maxLines: 20,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        hintText: 'Enter Description',
                      ),
                      controller: _descriptionController,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 3.h),
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
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection("Users")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection('Tasks')
                          .add({
                        "Title": _titleController.text,
                        "Description": _descriptionController.text,
                        "Schedule Date": selectedDate,
                        "Schedule Time": _timeController.text,
                        "Deadline Date": selectedDatedead,
                        "Deadline Time": _timeController1.text
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text('Add Task'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
