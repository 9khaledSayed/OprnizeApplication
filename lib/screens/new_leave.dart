import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oprnize/constant.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:oprnize/components/section_title.dart';
import 'package:oprnize/components/custom_checkbox.dart';
import 'package:oprnize/components/custom_radio_btn.dart';

class NewLeave extends StatefulWidget {
  @override
  _NewLeaveState createState() => _NewLeaveState();
}

class _NewLeaveState extends State<NewLeave> {
  double numberOfDays = 5;
  double min = 1;
  double max = 30;
  int leaveTypeID;
  List<String> additionalOptions = [];
  PickedFile _pickedFile;
  final ImagePicker picker = ImagePicker();

  DateTime startingDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: startingDate,
        firstDate: DateTime(2021, 4),
        lastDate: DateTime(2030));
    if (picked != null && picked != startingDate)
      setState(() {
        startingDate = picked;
      });
  }

  void takePhoto(ImageSource source) async {
    final _pickedFile = await picker.getImage(source: source);
  }

  Function onTap(value) {
    setState(() {
      leaveTypeID = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: Icon(
                          Icons.arrow_back,
                          size: 50.0,
                          color: KSecondaryColor,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      SectionTitle(title: 'New Leave Request'),
                      Icon(
                        Icons.add_circle,
                        size: 50.0,
                        color: KPrimaryColor,
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircularPercentIndicator(
                        radius: MediaQuery.of(context).size.width / 4.2,
                        lineWidth: 11,
                        percent: 50 / 100,
                        animation: true,
                        center: Text(
                          "21 days",
                          style: TextStyle(
                              color: KSecondaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                        progressColor: KSecondaryColor,
                      ),
                      Column(
                        children: [
                          Text(
                            "Account Balance",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black45),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            "16 Days",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SectionTitle(title: 'Leave Type :'),
                Wrap(
                  children: [
                    CustomRadioBtn(
                      label: 'Sickness',
                      value: 1,
                      groupValue: leaveTypeID,
                      onTap: () {
                        setState(() {
                          leaveTypeID = 1;
                        });
                        print(leaveTypeID);
                      },
                    ),
                    CustomRadioBtn(
                      label: 'Maternity',
                      value: 2,
                      groupValue: leaveTypeID,
                      onTap: () {
                        setState(() {
                          leaveTypeID = 2;
                        });
                        print(leaveTypeID);
                      },
                    ),
                    CustomRadioBtn(
                      label: 'Paternity',
                      value: 3,
                      groupValue: leaveTypeID,
                      onTap: () {
                        setState(() {
                          leaveTypeID = 3;
                        });
                        print(leaveTypeID);
                      },
                    ),
                    CustomRadioBtn(
                      label: 'Bereavement',
                      value: 4,
                      groupValue: leaveTypeID,
                      onTap: () {
                        setState(() {
                          leaveTypeID = 4;
                        });
                        print(leaveTypeID);
                      },
                    ),
                    CustomRadioBtn(
                      label: 'Bereavement',
                      value: 5,
                      groupValue: leaveTypeID,
                      onTap: () {
                        setState(() {
                          leaveTypeID = 5;
                        });
                        print(leaveTypeID);
                      },
                    ),
                    CustomRadioBtn(
                      label: 'Bereavement',
                      value: 6,
                      groupValue: leaveTypeID,
                      onTap: () {
                        setState(() {
                          leaveTypeID = 6;
                        });
                        print(leaveTypeID);
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SectionTitle(title: 'Number Of Days :'),
                    Container(
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: KPrimaryColor),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      child: Text(
                        numberOfDays.round().toString() + ' Days',
                        style: TextStyle(color: KPrimaryColor),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          '1',
                          style: TextStyle(
                            color: KPrimaryColor,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Slider(
                        value: numberOfDays,
                        min: min,
                        max: max,
                        activeColor: KPrimaryColor,
                        inactiveColor: Colors.black12,
                        onChanged: (double value) {
                          setState(() {
                            numberOfDays = value;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                          child: Text(
                        '30',
                        style: TextStyle(
                          color: KPrimaryColor,
                          fontWeight: FontWeight.w900,
                        ),
                      )),
                    ),
                  ],
                ),
                SectionTitle(
                  title: 'Starting Date :',
                ),
                InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                    margin: EdgeInsets.only(bottom: 20.0),
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
                    width: double.infinity,
                    height: 50.0,
                    child: Text("${startingDate.toLocal()}".split(' ')[0]),
                  ),
                  onTap: () {
                    _selectDate(context);
                  },
                ),
                Wrap(
                  children: [
                    CustomCheckbox(
                      label: 'Exist Re-entry Visa',
                      value: 'exist_reentry_visa',
                      isActive:
                          additionalOptions.contains('exist_reentry_visa'),
                      onTap: () {
                        setState(() {
                          if (additionalOptions
                              .contains('exist_reentry_visa')) {
                            additionalOptions.remove('exist_reentry_visa');
                          } else {
                            additionalOptions.add('exist_reentry_visa');
                          }
                        });
                        print(additionalOptions);
                      },
                    ),
                    CustomCheckbox(
                      label: 'Ticket',
                      value: 'ticket',
                      isActive: additionalOptions.contains('ticket'),
                      onTap: () {
                        setState(() {
                          if (additionalOptions.contains('ticket')) {
                            additionalOptions.remove('ticket');
                          } else {
                            additionalOptions.add('ticket');
                          }
                        });
                        print(additionalOptions);
                      },
                    ),
                    CustomCheckbox(
                      label: 'Advanced Salary',
                      value: 'advanced_salary',
                      isActive: additionalOptions.contains('advanced_salary'),
                      onTap: () {
                        setState(() {
                          if (additionalOptions.contains('advanced_salary')) {
                            additionalOptions.remove('advanced_salary');
                          } else {
                            additionalOptions.add('advanced_salary');
                          }
                        });
                        print(additionalOptions);
                      },
                    ),
                  ],
                ),
                SectionTitle(title: 'Attachments :'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      padding: EdgeInsets.all(20.0),
                      child: InkWell(
                        onTap: () {
                          takePhoto(ImageSource.gallery);
                          print(_pickedFile);
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.upload_rounded,
                              color: KPrimaryColor,
                            ),
                            Text(
                              'Upload File',
                              style:
                                  TextStyle(fontSize: 16, color: KPrimaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        takePhoto(ImageSource.camera);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(15),
                          ),
                        ),
                        padding: EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.camera_alt,
                              color: KPrimaryColor,
                            ),
                            Text(
                              'Camera Roll',
                              style:
                                  TextStyle(fontSize: 16, color: KPrimaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  height: 55,
                  width: MediaQuery.of(context).size.width - 40,
                  child: RaisedButton(
                    elevation: 5.0,
                    color: Color(0xFF42E8E0),
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(15))),
                    child: Text(
                      "Send",
                      style: TextStyle(
                          color: Colors.white, letterSpacing: 1, fontSize: 25),
                    ),
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
