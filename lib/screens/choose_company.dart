import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast2/fluttertoast.dart';

import '../constant.dart';
import 'package:http/http.dart' as http;

import 'login_screen.dart';

class ChooseCompany extends StatefulWidget {
  @override
  _ChooseCompanyState createState() => _ChooseCompanyState();
}

class _ChooseCompanyState extends State<ChooseCompany> {
  TextEditingController _name = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.white,
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
                  "Join your team space",
                  style: TextStyle(
                      color: Colors.blue[700],
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                )
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
                  "Company's Name",
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width - 50,
                  height: 55,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border:
                          Border(bottom: BorderSide(color: Colors.grey[100]))),
                  child: TextField(
                    controller: _name,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                        prefixIcon: IconButton(
                            icon: Icon(
                              Icons.link,
                              size: 30,
                              color: Colors.grey[500],
                            ),
                            onPressed: null),
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
                if (_name.text.isEmpty) {
                  Fluttertoast.showToast(
                      msg: "You must enter the name",
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else {
                  setState(() {
                    loading = true;
                  });

                  await checkCompany();
                  setState(() {
                    loading = false;
                  });
                }
              },
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(15))),
              child: Text(
                "submit",
                style: TextStyle(
                    color: Colors.white, letterSpacing: 1, fontSize: 25),
              ),
            ),
          ),
        ],
      ),
    ));
  }

// الدالة التي تتحقق من ال اسم الشركة
// function that check name of comapny
  Future checkCompany() async {
    try {
      http.Response response = await http.get(
        ApiUrl.cheekCompany + _name.text,
      );

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        if (body["status"] == 1) {
          Fluttertoast.showToast(
              msg: "you are belong your comapany : ${_name.text}",
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => LoginScreen(
                    nameCompany: _name.text,
                  )));
        } else {
          Fluttertoast.showToast(
              msg: body["1"],
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
      print(e);
      Fluttertoast.showToast(
          msg: "An error occurred, try again",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
