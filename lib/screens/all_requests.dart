import 'package:flutter/material.dart';
import 'package:oprnize/screens/all_leaves.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllRequests extends StatefulWidget {
  @override
  _AllRequestsState createState() => _AllRequestsState();
}

class _AllRequestsState extends State<AllRequests> {
  var fullName, image;
  @override
  void initState() {
    _getUserinformation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                ),
                header(),
                buttons(),
                SizedBox(
                  height: 60,
                )
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.indigo[900],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Tap To View All Requests",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Icon(
                          Icons.arrow_right,
                          color: Colors.white,
                          size: 25,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

// الودجت الذي يحتوي على الاسم والصورة
// widget contain name and phot user
  Widget header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 150,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
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
            SizedBox(
              width: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome",
                  style: TextStyle(color: Colors.black38),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  fullName ?? "",
                  style: TextStyle(
                      fontSize: 19,
                      color: Colors.blue[700],
                      fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

// الودجت التي تحتوي على الازرار
// widget that contains all buttons
  Widget buttons() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              button("assets/icons/4.png", "Leave", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AllLeaves()),
                );
              }),
              button("assets/icons/3.png", "Excuse", () {}),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              button("assets/icons/7.png", "Cover Letter", () {}),
              button("assets/icons/6.png", "Expense", () {}),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              button("assets/icons/2.png", "Resignation", () {}),
              button("assets/icons/5.png", "Pay Slip", () {}),
            ],
          ),
        ],
      ),
    );
  }

// الودجت التي تحتوي على تركيب الزر
// // widget that contain componets of button
  Widget button(icon, text, function) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.width / 2.7,
          width: MediaQuery.of(context).size.width / 2.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(18)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[400].withOpacity(0.4),
                  spreadRadius: 3,
                  blurRadius: 4)
            ],
            //    borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                icon,
                height: MediaQuery.of(context).size.width / 8,
                width: MediaQuery.of(context).size.width / 8,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.blue[700]),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _getUserinformation() async {
    SharedPreferences users = await SharedPreferences.getInstance();
    setState(() {
      fullName = users.get("name_en");
      image = users.get("photo");
    });
  }
}
