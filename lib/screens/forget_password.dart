import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:fluttertoast2/fluttertoast.dart';

import '../constant.dart';

class ForgetPaswword extends StatefulWidget {
  @override
  _ForgetPaswwordState createState() => _ForgetPaswwordState();
}

class _ForgetPaswwordState extends State<ForgetPaswword> {
  TextEditingController _email = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  "Forget Your password ?",
                  style: TextStyle(
                      color: Colors.blue[700],
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 45,
                  child: Text(
                    "Enter your e-mail to send link for reset your password",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 17,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  "Your Email",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width - 45,
                  height: 55,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border:
                          Border(bottom: BorderSide(color: Colors.grey[100]))),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _email,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey[400])),
                  ),
                ),
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
              : SizedBox(
                  height: 50,
                ),
          Container(
            height: 55,
            width: MediaQuery.of(context).size.width - 40,
            child: RaisedButton(
              elevation: 5.0,
              color: Colors.blue[700],
              onPressed: () async {
                if (_email.text.isEmpty) {
                  Fluttertoast.showToast(
                      msg: "You must enter the email",
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else {
                  setState(() {
                    loading = true;
                  });
                  await sendCode();
                  setState(() {
                    loading = false;
                  });
                }
              },
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(15))),
              child: Text(
                "send",
                style: TextStyle(
                    color: Colors.white, letterSpacing: 1, fontSize: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }
  // الدالة استرجاع كلمة المرور
  // function reset password

  Future sendCode() async {
    try {
      http.Response response =
          await http.post(ApiUrl.forgetPassword, body: {"email": _email.text});
      var body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (body["status"] == 200) {
          Fluttertoast.showToast(
              msg: "chck your email, we sent the resting",
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.pop(context);
        } else if (body["status"] == 400) {
          Fluttertoast.showToast(
              msg: "user does not exist",
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          Fluttertoast.showToast(
              msg: "An error occurred, try again",
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
