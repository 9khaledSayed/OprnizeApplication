import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oprnize/components/section_title.dart';
import 'package:oprnize/constant.dart';
import 'package:oprnize/screens/new_leave.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AllLeaves extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(25.0),
          child: ListView(
            children: [
              Container(
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
                    SectionTitle(title: 'Leave'),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NewLeave()),
                        );
                      },
                      child: Icon(
                        Icons.add_circle,
                        size: 50.0,
                        color: KPrimaryColor,
                      ),
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
              Leave(
                name: 'Sick',
                numberOfDays: '10',
                requestDate: '6/12/2018',
                status: 'rejected',
              ),
              Leave(
                name: 'Maternity',
                numberOfDays: '5',
                requestDate: '6/12/2018',
                status: 'Approved',
              ),
              Leave(
                name: 'Paternity',
                numberOfDays: '10',
                requestDate: '6/12/2018',
                status: 'Approved',
              ),
              Leave(
                name: 'Bereavement',
                numberOfDays: '10',
                requestDate: '6/12/2018',
                status: 'rejected',
              ),
              Leave(
                name: 'Privilege',
                numberOfDays: '10',
                requestDate: '6/12/2018',
                status: 'rejected',
              ),
              Leave(
                name: 'Casual',
                numberOfDays: '10',
                requestDate: '6/12/2018',
                status: 'rejected',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Leave extends StatelessWidget {
  Leave({
    @required this.name,
    @required this.numberOfDays,
    @required this.requestDate,
    @required this.status,
  });

  final String name;
  final String numberOfDays;
  final String requestDate;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 13.0),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Number Of Days:',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black45,
                        ),
                      ),
                      SizedBox(height: 13.0),
                      Text(
                        'Request Date:',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(numberOfDays),
                      SizedBox(height: 13.0),
                      Text(requestDate),
                    ],
                  )
                ],
              )
            ],
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: status == 'rejected' ? Colors.red : Colors.green,
            ),
            padding: EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 18.0,
            ),
            child: Text(
              status,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
