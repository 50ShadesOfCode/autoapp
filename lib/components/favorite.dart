import 'package:auto_app/utils/FavModel.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'carCard.dart';

Future<List<String>> buildList() async {
  var docsPath = await getApplicationDocumentsDirectory();
  var db = await openDatabase(docsPath.path + 'autofavs.db', version: 1,
      onCreate: (Database db, int version) async {
    await db.execute("CREATE TABLE Favs ("
        "url TEXT"
        ")");
  });
  var res = await db.query("Favs");
  List<FavModel> list =
      res.isNotEmpty ? res.map((c) => FavModel.fromMap(c)).toList() : [];
  List<String> urls = [];
  for (FavModel ms in list) {
    urls.add(ms.url);
  }
  return urls;
}

class Favorite extends StatelessWidget {
  static const String routeName = '/favs';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Избранные'),
      ),
      body: FavListScreen(),
    );
  }
}

class FavListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
        future: buildList(),
        builder: (BuildContext context, AsyncSnapshot<List<String>> snap) {
          return Container(
            margin: EdgeInsets.all(5),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    //addAutomaticKeepAlives: true,
                    itemCount: snap.data?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CarCard(
                        cardUrl: snap.data?[index] as String,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}
