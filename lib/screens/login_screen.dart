import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast2/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:oprnize/models/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';
import 'forget_password.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  final String nameCompany;
  LoginScreen({this.nameCompany});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  bool loading = false;

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 60,
            ),
            Image.asset(
              "assets/images/bannar.png",
              height: 200,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    "Sign in now",
                    style: TextStyle(
                        color: Colors.blue[700],
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    "Hello , Welcome back! ",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    "Email ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                alignment: Alignment.center,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border:
                        Border(bottom: BorderSide(color: Colors.grey[100]))),
                child: TextFormField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                      icon: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Icon(Icons.email_outlined),
                      ),
                      border: InputBorder.none,
                      hintText: "example@gmail.com",
                      hintStyle: TextStyle(color: Colors.grey[500])),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Text(
                    "password ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border:
                        Border(bottom: BorderSide(color: Colors.grey[100]))),
                child: TextFormField(
                  controller: _password,
                  validator: (val) =>
                      val.length < 6 ? 'Password too short.' : null,
                  //  onSaved: (val) => _passwords = val,
                  obscureText: _obscureText,
                  keyboardType: TextInputType.visiblePassword,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                      suffix: IconButton(
                        splashColor: Colors.white,
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: _toggle,
                      ),
                      icon: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Icon(Icons.lock_open_outlined),
                      ),
                      border: InputBorder.none,
                      hintText: "*****************",
                      hintStyle: TextStyle(color: Colors.grey[500])),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ForgetPaswword()));
                      },
                      child: Text(
                        "Forget Password?",
                        style: TextStyle(color: Colors.blue, fontSize: 20),
                      ))
                ],
              ),
            ),
            loading
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Container(
                    height: 50,
                  ),
            Container(
              height: 55,
              width: MediaQuery.of(context).size.width - 40,
              child: RaisedButton(
                elevation: 5.0,
                color: Colors.blue[700],
                onPressed: () async {
                  if (_email.text.isEmpty || _password.text.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "You must enter email & password",
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  } else if (_password.text.length < 6) {
                    Fluttertoast.showToast(
                        msg: "password must larger 6 digits",
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  } else {
                    setState(() {
                      loading = true;
                    });
                    await login();
                    setState(() {
                      loading = false;
                    });
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(15))),
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.white, letterSpacing: 1, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<UserModel> login() async {
    try {
      UserModel user;
      http.Response response = await http.post(ApiUrl.loginUrl,
          body: {"email": _email.text, "password": _password.text});
      var body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        user = UserModel.fromJson(body["user"]);
        SharedPreferences users = await SharedPreferences.getInstance();
        users.setString('token', body["token"]);
        users.setInt("id", user.id);
        users.setString("company_id", user.companyId);
        users.setString("provider_id", user.providerId);
        users.setString("department_id", user.departmentId);
        users.setString("section_id", user.sectionId);
        users.setString("supervisor_id", user.supervisorId);
        users.setString("work_shift_id", user.workShiftId);
        users.setString("nationality_id", user.nationalityId);
        users.setString("job_title_id", user.jobTitleId);
        users.setString("role_id", user.roleId);
        users.setString("name_ar", user.nameAr);
        users.setString("name_en", user.nameEn);
        users.setString("city_id", user.cityId);
        users.setString("fname_ar", user.fnameAr);
        users.setString("sname_ar", user.snameAr);
        users.setString("tname_ar", user.tnameAr);
        users.setString("lname_ar", user.lnameAr);
        users.setString("fname_en", user.fnameEn);
        users.setString("sname_en", user.snameEn);
        users.setString("tname_en", user.tnameAr);
        users.setString("lname_en", user.lnameEn);
        users.setString("photo", user.photo);
        users.setString("city_name_ar", user.cityNameAr);
        users.setString("city_name_en", user.cityNameEn);
        users.setString("job_number", user.jobNumber);
        users.setString("birthdate", user.birthdate);
        users.setString("marital_status", user.maritalStatus);
        users.setString("gender", user.gender);
        users.setString("test_period", user.testPeriod);
        users.setString("id_num", user.idNum);
        users.setString("id_issue_date", user.idIssueDate);
        users.setString("id_expire_date", user.idExpireDate);
        users.setString("passport_num", user.passportNum);
        users.setString("passport_issue_date", user.passportIssueDate);
        users.setString("passport_expire_date", user.passportExpireDate);
        users.setString("issue_place", user.issuePlace);
        users.setString("contract_type", user.contractType);
        users.setString("contract_start_date", user.contractStartDate);
        users.setString("contract_end_date", user.contractEndDate);
        users.setString("contract_period", user.contractPeriod);
        users.setString("allowance", user.allowance);
        users.setString("phone", user.phone);
        users.setString("leave_balance", user.leaveBalance);
        users.setString("available_balance", user.availableBalance);
        users.setString("barcode", user.barcode);
        users.setString("service_status", user.serviceStatus);
        users.setString("email", user.email);
        users.setString("email_verified_at", user.emailVerifiedAt);
        users.setString("salary", user.salary);
        users.setString("is_completed", user.isCompleted);
        users.setString("created_at", user.createdAt);
        users.setString("updated_at", user.updatedAt);
        users.setString("compensation", user.compensation);
        users.setString("compensation_type", user.compensationType);
        users.setString("notification_period", user.notificationPeriod);
        users.setString("end_service", user.endService);
        users.setString("type_end_service", user.typeEndService);
        users.setString("date_end_service", user.dateEndService);
        users.setString("availabel_balance", user.availabelBalance);
        users.setString("used_balance", user.usedBalance);
        Fluttertoast.showToast(
            msg: "successfully logged in",
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));

        return user;
      } else {
        Fluttertoast.showToast(
            msg: body["message"],
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "An error occurred, try again",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return null;
    }
  }
}
