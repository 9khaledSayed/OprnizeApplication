import 'package:flutter/material.dart';

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
        //  backgroundColor: Colors.white,
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 60,
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
                  "Enter your company's ",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 17,
                  ),
                ),
                Text(
                  "Oprnize Url ",
                  style: TextStyle(
                    color: Colors.grey[900],
                    fontSize: 17,
                  ),
                ),
                Text(
                  "below",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 17,
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
              children: [
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 2,
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
                Text(
                  "  .oprnize.com",
                  style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                )
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
              color: Colors.blue[500],
              onPressed: () async {},
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(15))),
              child: Text(
                "submit",
                style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 1,
                    fontSize: MediaQuery.of(context).size.width / 25),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
