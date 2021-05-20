import 'dart:async';
import 'dart:convert';

import 'package:auto_app/components/carPage.dart';
import 'package:auto_app/components/themeProvider.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

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

class _CarCardState extends State<CarCard> with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  _CarCardState(this.cardUrl);
  final String cardUrl;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: getCardParameters(this.cardUrl),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          final provider = Provider.of<ThemeProvider>(context);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                decoration: BoxDecoration(
                  color: (provider.isDarkMode ? Colors.black : Colors.white),
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
                child: Center(
                  child: Text("Waiting response!!"),
                ));
          }
          if (snapshot.data == null) {
            return Container(
                decoration: BoxDecoration(
                  color: (provider.isDarkMode ? Colors.black : Colors.white),
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
                child: Center(
                  child: Text("Check your Internet connection!!"),
                ));
          }
          Map<String, dynamic> cChars = snapshot.data as Map<String, dynamic>;
          if (!this.cardUrl.contains("/new/")) {
            return Container(
              decoration: BoxDecoration(
                color: (provider.isDarkMode ? Colors.black : Colors.white),
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
                        child: Image(
                          image: NetworkImage(
                              "http://" + cChars["images_urls"][0].toString()),
                        ),
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
                    child: StarButton(
                      iconSize: 45,
                      valueChanged: (value) async {
                        if (value) {
                          var docsPath =
                              await getApplicationDocumentsDirectory();
                          var db = await openDatabase(
                              docsPath.path + 'autofavs.db',
                              version: 1,
                              onCreate: (Database db, int version) async {
                            await db.execute("CREATE TABLE Favs ("
                                "url TEXT"
                                ")");
                          });
                          print("inserted");
                          var raw = await db.rawInsert(
                              "INSERT Into Favs (url)"
                              " VALUES (?)",
                              [this.cardUrl]);
                          print("ins");
                        } else {
                          var docsPath =
                              await getApplicationDocumentsDirectory();
                          var db = await openDatabase(
                              docsPath.path + 'autofavs.db',
                              version: 1,
                              onCreate: (Database db, int version) async {
                            await db.execute("CREATE TABLE Favs ("
                                "url TEXT"
                                ")");
                          });
                          db.delete("Favs",
                              where: "url = ?", whereArgs: [this.cardUrl]);
                          print("del");
                        }
                      },
                    ),
                  ),
                ]),
              ),
            );
          } else {
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
                        child: Image(
                          image: NetworkImage(
                              "http://" + cChars["images_urls"][0].toString()),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 30,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(cChars["complectation"].toString()),
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
                    child: StarButton(
                      iconSize: 45,
                      valueChanged: (value) async {
                        if (value) {
                          var docsPath =
                              await getApplicationDocumentsDirectory();
                          var db = await openDatabase(
                              docsPath.path + 'autofavs.db',
                              version: 1,
                              onCreate: (Database db, int version) async {
                            await db.execute("CREATE TABLE Favs ("
                                "url TEXT"
                                ")");
                          });
                          print("inserted");
                          var raw = await db.rawInsert(
                              "INSERT Into Favs (url)"
                              " VALUES (?)",
                              [this.cardUrl]);
                          print("ins");
                        } else {
                          var docsPath =
                              await getApplicationDocumentsDirectory();
                          var db = await openDatabase(
                              docsPath.path + 'autofavs.db',
                              version: 1,
                              onCreate: (Database db, int version) async {
                            await db.execute("CREATE TABLE Favs ("
                                "url TEXT"
                                ")");
                          });
                          db.delete("Favs",
                              where: "url = ?", whereArgs: [this.cardUrl]);
                          print("del");
                        }
                      },
                    ),
                  ),
                ]),
              ),
            );
          }
        });
  }
}

Future<Map<String, dynamic>> getCardParameters(carUrl) async {
  print(carUrl);
  var url = Uri.parse("https://autoparseru.herokuapp.com/getCardByUrl");
  var body = json.encode({"url": carUrl});
  var res = await http.post(url, body: body, headers: headers);
  if (res.statusCode == 200) {
    Map<String, dynamic> jsonRes = json.decode(res.body);
    return jsonRes;
  } else {
    return Map<String, dynamic>();
  }
}
