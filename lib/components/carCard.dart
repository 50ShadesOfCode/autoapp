import 'dart:async';
import 'dart:convert';

import 'package:auto_app/components/carPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CarCard extends StatefulWidget {
  final String cardUrl;
  CarCard({required String cardUrl}) : this.cardUrl = cardUrl;
  @override
  _CarCardState createState() => _CarCardState(cardUrl);
}

Map<String, String> headers = {
  'Content-type': 'application/json',
  'Accept': 'application/json; charset=UTF-8',
};

class _CarCardState extends State<CarCard> {
  _CarCardState(this.cardUrl);
  final String cardUrl;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: getCardParameters(this.cardUrl),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.data == null) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.blueAccent,
                  width: 3,
                  style: BorderStyle.solid,
                ),
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.15,
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Text("Check your Internet connection!!"),
            );
          }
          Map<String, dynamic> cChars = snapshot.data as Map<String, dynamic>;
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.blueAccent.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.blueAccent,
                width: 3,
                style: BorderStyle.solid,
              ),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.15,
            margin: EdgeInsets.symmetric(vertical: 5),
            child: InkWell(
              onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CarPage(carUrl: this.cardUrl)))
              },
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Expanded(
                  flex: 25,
                  child: InkWell(
                    onTap: () => {print("Open images")},
                    child: Container(
                      child: Text("Images"),
                    ),
                  ),
                ),
                Expanded(
                  flex: 30,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(cChars["kmage"].toString()),
                        margin: EdgeInsets.symmetric(vertical: 3),
                      ),
                      Container(
                        child: Text(cChars["engine"].toString()),
                        margin: EdgeInsets.symmetric(vertical: 3),
                      ),
                      Container(
                        child: Text(cChars["transmission"].toString()),
                        margin: EdgeInsets.symmetric(vertical: 3),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 15,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          child: Text(cChars["color"].toString()),
                          margin: EdgeInsets.symmetric(vertical: 3)),
                      Container(
                        child: Text(cChars["drive"].toString()),
                        margin: EdgeInsets.symmetric(vertical: 3),
                      ),
                      Container(
                        child: Text(cChars["body"].toString()),
                        margin: EdgeInsets.symmetric(vertical: 3),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: IconButton(
                    icon: new Icon(CupertinoIcons.star),
                    onPressed: () => {},
                  ),
                ),
              ]),
            ),
          );
        });
  }
}

Future<Map<String, dynamic>> getCardParameters(carUrl) async {
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
