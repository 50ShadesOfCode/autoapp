import 'dart:convert';

import 'package:auto_app/components/carousel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Map<String, String> headers = {
  'Content-type': 'application/json',
  'Accept': 'application/json; charset=UTF-8',
};

Future<Map<String, dynamic>> getCarParameters(carUrl) async {
  var url = Uri.parse("http://localhost:5000/getCardByUrl");
  var body = json.encode({"url": carUrl});
  var res = await http.post(url, body: body, headers: headers);
  if (res.statusCode == 200) {
    Map<String, dynamic> jsonRes = json.decode(res.body);
    return jsonRes;
  } else {
    return Map<String, dynamic>();
  }
}

class CarPage extends StatefulWidget {
  final String carUrl;
  CarPage({required String carUrl}) : this.carUrl = carUrl;
  @override
  _CarPageState createState() => _CarPageState(carUrl);
}

class _CarPageState extends State<CarPage> {
  _CarPageState(this.carUrl);
  final String carUrl;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: getCarParameters(this.carUrl),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.timelapse,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          );
        }
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              child: Center(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 50),
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: 300,
                      child: CarouselWithIndicatorDemo(),
                      decoration: BoxDecoration(
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Характеристики",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 3),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Год выпуска",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  flex: 50,
                                ),
                                Expanded(
                                  child: Text(
                                    "2020",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  flex: 50,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 3),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Год выпуска",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  flex: 50,
                                ),
                                Expanded(
                                  child: Text(
                                    "2020",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  flex: 50,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 3),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Год выпуска",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  flex: 50,
                                ),
                                Expanded(
                                  child: Text(
                                    "2020",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  flex: 50,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 3),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Год выпуска",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  flex: 50,
                                ),
                                Expanded(
                                  child: Text(
                                    "2020",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  flex: 50,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 3),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Год выпуска",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  flex: 50,
                                ),
                                Expanded(
                                  child: Text(
                                    "2020",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  flex: 50,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 3),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Год выпуска",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  flex: 50,
                                ),
                                Expanded(
                                  child: Text(
                                    "2020",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  flex: 50,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 3),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Год выпуска",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  flex: 50,
                                ),
                                Expanded(
                                  child: Text(
                                    "2020",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  flex: 50,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 3),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Год выпуска",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  flex: 50,
                                ),
                                Expanded(
                                  child: Text(
                                    "2020",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  flex: 50,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 3),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Год выпуска",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  flex: 50,
                                ),
                                Expanded(
                                  child: Text(
                                    "2020",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  flex: 50,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 3),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Год выпуска",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  flex: 50,
                                ),
                                Expanded(
                                  child: Text(
                                    "2020",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  flex: 50,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 3),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Год выпуска",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  flex: 50,
                                ),
                                Expanded(
                                  child: Text(
                                    "2020",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  flex: 50,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 3),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Год выпуска",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  flex: 50,
                                ),
                                Expanded(
                                  child: Text(
                                    "2020",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  flex: 50,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 3),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Год выпуска",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  flex: 50,
                                ),
                                Expanded(
                                  child: Text(
                                    "2020",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  flex: 50,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 3),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Год выпуска",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  flex: 50,
                                ),
                                Expanded(
                                  child: Text(
                                    "2020",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  flex: 50,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 3),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Год выпуска",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  flex: 50,
                                ),
                                Expanded(
                                  child: Text(
                                    "2020",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  flex: 50,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                        "Комментарий продавца",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        "Random commentjbksakjfbasjfbaskjbfaskjbfka jsbfbaskjfbaskfbkjasbfkjasb ajkbsfbas fjasjk bfakjsb fkjaskj kaj bkfjajkbfksaj b",
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
