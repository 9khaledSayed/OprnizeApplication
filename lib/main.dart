import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oprnize/screens/choose_company.dart';
import 'package:oprnize/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences users = await SharedPreferences.getInstance();
  var token = users.getString("token");
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(MyApp(
    token: token,
  ));
}

class MyApp extends StatelessWidget {
  final token;
  MyApp({this.token});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Lato"),
      home: token == null ? ChooseCompany() : HomeScreen(),
    );
  }
}
