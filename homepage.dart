import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/services.dart';

class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  int _person = 1;

  int _tipPercentage = 0;
  double _billAmount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Bill Splitter'),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Resets all the values',
        onPressed: () {
          setState(() {
            _reset();
          });
        },
        child: Icon(Icons.refresh_outlined),
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(30.0),
                width: 320.0,
                height: 200.0,
                decoration: BoxDecoration(
                    //border: Border.all(width: 1.0, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(20.0),
                    //backgroundBlendMode: BlendMode.colorBurn,
                    color: Colors.lightBlue.shade50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Text("Total per person :",
                            style: TextStyle(
                                color: Colors.blue.shade900,
                                fontSize: 15.0,
                                fontWeight: FontWeight.normal))),
                    SizedBox(height: 15.0),
                    Center(
                        child: Text(
                            "₹ ${totalperperson(_billAmount, _person, _tipPercentage)}",
                            style: TextStyle(
                                color: Colors.blue.shade900,
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold)))
                  ],
                ),
              )
            ],
          ),
          // Expanded(
          //   child:
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 320.0,
                height: 300.0,
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    border: Border.all(width: 0.5, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.transparent),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
                      child: TextField(
                        onChanged: (String value) {
                          try {
                            _billAmount = double.parse(value);
                          } catch (exception) {
                            _billAmount = 0.0;
                          }
                        },
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        style: TextStyle(
                            fontStyle: FontStyle.normal,
                            color: Colors.blue.shade900,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                            labelText: 'Bill amount',
                            hintText: 'Enter bill amount...',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.0))),
                      ),
                    ),
                    // Expanded(
                    //   child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            margin: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                            child: Text(
                              "Split",
                              style: TextStyle(
                                  color: Colors.grey.shade700, fontSize: 18.0),
                            )),
                        // Expanded(
                        //   child:

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (_person > 1) {
                                    _person--;
                                  }
                                });
                              },
                              child: Container(
                                  margin:
                                      EdgeInsets.only(right: 10.0, left: 10.0),
                                  child: Center(
                                      child: Text(
                                    "-",
                                    style: TextStyle(
                                        color: Colors.blue.shade900,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 40.0),
                                  )),
                                  height: 50.0,
                                  width: 50.0,
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlue.shade50,
                                    borderRadius: BorderRadius.circular(10.0),
                                  )),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 10.0, left: 10.0),
                              child: Text(
                                '$_person',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.blue.shade900,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _person++;
                                });
                              },
                              child: Container(
                                  margin:
                                      EdgeInsets.only(right: 10.0, left: 10.0),
                                  child: Center(
                                      child: Text(
                                    "+",
                                    style: TextStyle(
                                        color: Colors.blue.shade900,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 30.0),
                                  )),
                                  height: 50.0,
                                  width: 50.0,
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlue.shade50,
                                    borderRadius: BorderRadius.circular(10.0),
                                  )),
                            ),
                          ],
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10.0, 20.0, 20.0, 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Tip",
                              style: TextStyle(
                                  color: Colors.grey.shade700, fontSize: 18.0)),
                          Text(
                              "₹ ${calculatetotaltip(_billAmount, _person, _tipPercentage).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w900,
                                color: Colors.blue.shade900,
                              ))
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Text("$_tipPercentage%",
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w900,
                                color: Colors.blue.shade900)),
                        Slider(
                            divisions: 10,
                            activeColor: Colors.blue.shade900,
                            min: 0,
                            max: 100,
                            value: _tipPercentage.toDouble(),
                            onChanged: (double Newvalue) {
                              setState(() {
                                _tipPercentage = Newvalue.round();
                              });
                            })
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          // )
        ],
      ),
    );
  }

  calculatetotaltip(double bill, int split, int percent) {
    var totaltip = 0.0;

    if (bill < 0 || bill.toString().isEmpty) {
      //nogo

    } else {
      totaltip = (bill * percent) / 100;
    }
    return totaltip;
  }

  totalperperson(double bill, int split, int percent) {
    double perperson = (bill + calculatetotaltip(bill, split, percent)) / split;

    return perperson.toStringAsFixed(2);
  }

  _reset() {
    // if (_billAmount != 0.0) {
    _billAmount = 0.0;
    _person = 1;
    _tipPercentage = 0;
    // }
  }
}
