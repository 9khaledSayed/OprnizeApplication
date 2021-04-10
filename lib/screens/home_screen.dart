import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast2/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:oprnize/models/homeScreenModel.dart';
import 'package:oprnize/screens/all_requests.dart';
import 'package:oprnize/screens/choose_company.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../constant.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var fullName, image, idNumber, token;
  String idDevice;
  String lat = "";
  String lang = "";
  @override
  void initState() {
    _getUserinformation();
    _getId();
    _getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: gettingData(),
            builder: (context, snaposhot) {
              if (snaposhot.hasData) {
                HomeScreenModel homeScreenModel = snaposhot.data;

                return Stack(
                  fit: StackFit.expand,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          userInformation(),
                          SizedBox(
                            height: 20,
                          ),
                          dashboard(
                              homeScreenModel.presentPercentage,
                              homeScreenModel.absentPercentage,
                              homeScreenModel.balancePercentage),
                          SizedBox(
                            height: 20,
                          ),
                          attendace(),
                          SizedBox(
                            height: 20,
                          ),
                          data(
                              homeScreenModel.workingDays,
                              homeScreenModel.workingHours,
                              homeScreenModel.availableBalance,
                              homeScreenModel.numberOfLeaves),
                          Container(
                            height: 60,
                          )
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          children: [
                            Center(
                              child: IconButton(
                                  icon: Icon(
                                    Icons.logout,
                                    color: Colors.blue[700],
                                    size: 35,
                                  ),
                                  onPressed: () async {
                                    await logout();
                                  }),
                            ),
                            Spacer(),
                            Center(
                              child: IconButton(
                                  icon: Icon(
                                    Icons.add_circle_outline,
                                    color: Colors.blue[700],
                                    size: 35,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                AllRequests()));
                                  }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                return Center(
                    child: Container(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(),
                ));
              }
            }));
  }

// الدالة الي تجيب الاسم والصورة والتوكن والاي دي الخاص باليوزر والتي تم جفظها بالشيرد
// function that getting name , idNumber , photo and token from shared preferences
  _getUserinformation() async {
    SharedPreferences users = await SharedPreferences.getInstance();
    setState(() {
      token = users.get("token");
      fullName = users.get("name_en");
      image = users.get("photo");
      idNumber = users.get("job_number");
    });
  }

// الودجت التي تعرض بيانات اليوزر الموجودة باعلى الصفحة
// widget that view user data
  Widget userInformation() {
    return Container(
      height: 250,
      color: Colors.white,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          Spacer(),
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white60, width: 2),
            ),
            padding: EdgeInsets.all(8),
            child: CircleAvatar(
              backgroundImage: image == null
                  ? AssetImage("assets/images/profile.png")
                  : NetworkImage(image),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              fullName ?? "",
              style: TextStyle(
                  fontSize: 19,
                  color: Colors.blue[700],
                  fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "IDNumber : ",
                style: TextStyle(fontSize: 14, color: Colors.black45),
              ),
              Text(
                idNumber ?? "",
                style: TextStyle(fontSize: 17),
              ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }

// الودجت التي تحتوي على رسومات الداشبورد
// widget that contains dashbord
  Widget dashboard(parsent, absent, leave) {
    return Container(
      alignment: Alignment.center,
      height: 200,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularPercentIndicator(
                radius: MediaQuery.of(context).size.width / 4.2,
                lineWidth: 11,
                percent: parsent / 100,
                animation: true,
                center: new Text(
                  parsent.toString() + "%",
                  style: TextStyle(
                      color: Colors.blue[900],
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                progressColor: Colors.green[400],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "present",
                  style: TextStyle(
                      color: Colors.blue[700],
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularPercentIndicator(
                radius: MediaQuery.of(context).size.width / 4,
                lineWidth: 11,
                percent: absent / 100,
                animation: true,
                center: new Text(
                  absent.toString() + "%",
                  style: TextStyle(
                      color: Colors.blue[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                progressColor: Colors.pink,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Absent",
                  style: TextStyle(
                      color: Colors.blue[700],
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularPercentIndicator(
                radius: MediaQuery.of(context).size.width / 4,
                lineWidth: 11,
                percent: leave / 100,
                animation: true,
                center: new Text(
                  leave.toString() + "%",
                  style: TextStyle(
                      color: Colors.blue[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                progressColor: Colors.blue[700],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Leave",
                  style: TextStyle(
                      color: Colors.blue[700],
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

// الودجت الي يحتوي على زر الانصراف والحضور
// widget that conrains button chek in chek out
  Widget attendace() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width / 1.2,
          child: RaisedButton(
            elevation: 5.0,
            color: Colors.blue[700],
            onPressed: () async {
              if (lat == "" || lang == "") {
                Fluttertoast.showToast(
                    msg: "please give app location permission and open gps",
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              } else {
                await getAttendace();
              }
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(15),
                  bottomLeft: Radius.circular(5),
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5)),
            ),
            child: Text(
              "punch",
              style: TextStyle(
                  color: Colors.white, letterSpacing: 1.5, fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }

// الودجت التي تعرض ايام العمل وعدد الساعات و الرصيد المتبقي و عدد الاجازات
// widget that contains (working days, total working hours, balance days , number of leaves)
  Widget data(workingDays, totalWorkingHours, balanceDays, numbersOfLeaves) {
    return Container(
      height: 200,
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Working Days",
                  style: TextStyle(color: Colors.blue[700], fontSize: 17),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "$workingDays Days",
                  style: TextStyle(color: Colors.black45, fontSize: 16),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Total Working Hours",
                  style: TextStyle(color: Colors.blue[700], fontSize: 17),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "$totalWorkingHours Hours",
                  style: TextStyle(color: Colors.black45, fontSize: 16),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Balance Days",
                  style: TextStyle(color: Colors.blue[700], fontSize: 17),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "$balanceDays Leaves",
                  style: TextStyle(color: Colors.black45, fontSize: 16),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Number Of Leaves",
                  style: TextStyle(color: Colors.blue[700], fontSize: 16),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "$numbersOfLeaves Leaves",
                  style: TextStyle(color: Colors.black45, fontSize: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

// الدالة التي تعمل تسجيل خروج ومسح التوكن من الشيرد
// logout function and delete token from shared preferences
  Future logout() async {
    try {
      http.Response response = await http.post(
        ApiUrl.logout,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );
      SharedPreferences users = await SharedPreferences.getInstance();
      users.setString('token', null);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => ChooseCompany()));
      Fluttertoast.showToast(
          msg: "You have been successfully logged out",
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (e) {
      SharedPreferences users = await SharedPreferences.getInstance();
      users.setString('token', null);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => ChooseCompany()));
      Fluttertoast.showToast(
          msg: "You have been successfully logged out",
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

// الدالة التي تعمل على جلب المعلومات المعروضة بالصفحة
// function that get all data that view in the bage from api
  Future<HomeScreenModel> gettingData() async {
    SharedPreferences users = await SharedPreferences.getInstance();
    var _token = users.get("token");

    HomeScreenModel homeScreenModel;
    try {
      http.Response response = await http.get(
        ApiUrl.getDataHomeScreen,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $_token",
        },
      );
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        homeScreenModel = HomeScreenModel.fromJson(body);
        return homeScreenModel;
      } else {
        SharedPreferences users = await SharedPreferences.getInstance();
        users.setString('token', null);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => ChooseCompany()));
        Fluttertoast.showToast(
            msg: "please sign in again",
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);

        return null;
      }
    } catch (e) {
      SharedPreferences users = await SharedPreferences.getInstance();
      users.setString('token', null);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => ChooseCompany()));
      Fluttertoast.showToast(
          msg: "please sign in again",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return null;
    }
  }

// الدالة التي تحصل على اي دي الخاص بالجهاز
// function getting id phone
  Future<String> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      idDevice = iosDeviceInfo.identifierForVendor;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      idDevice = androidDeviceInfo.androidId;
      print(androidDeviceInfo.androidId);
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }

// الدالة التي تجلب اللوكيشن الخاص باليوزر
// function that getting loaction of user
  void _getCurrentLocation() async {
    try {
      final position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      setState(() {
        lat = position.latitude.toString();
        lang = position.longitude.toString();
      });
      print(lat);
      print(lang);
    } catch (e) {
      print(e);
    }
  }

// الدالة التي تعمل على تسجيل الحضور والانصراف
// function that working chek in $ chek out
  Future getAttendace() async {
    try {
      http.Response response = await http.post(
        ApiUrl.attendace,
        body: {"lat": lat, "lang": lang, "ip_address": idDevice},
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );
      var body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (body["status"] == true) {
          Fluttertoast.showToast(
              msg: body["message"],
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          Fluttertoast.showToast(
              msg: body["message"],
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } else {
        Fluttertoast.showToast(
            msg: "An error occurred, try again",
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "An error occurred, try again",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
