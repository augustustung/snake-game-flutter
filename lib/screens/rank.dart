import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Rank extends StatefulWidget {
  @override
  _RankState createState() => _RankState();
}

class _RankState extends State<Rank> {
  List users = [];
  bool _isLoading = true;

  Future fetchData() async {
    List loadData = [];

    var url = Uri.parse(
        "https://flutter-app-b5379-default-rtdb.asia-southeast1.firebasedatabase.app/highScore.json");
    try {
      var response = await http.get(url);
      final loadedData = json.decode(response.body) as Map<String, dynamic>;
      loadedData.forEach((key, value) {
        // print("value: ${value}\nkey: ${key}");
        loadData.add({"name": value["name"], "score": value["score"]});
      });

      loadData.sort((a, b) => b["score"].compareTo(a["score"]));
      loadData.reversed;
      setState(() {
        users = loadData;
      });
    } catch (e) {
      print(e);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('RANK'),
          leading: IconButton(
              icon: Icon(Icons.keyboard_arrow_left_rounded),
              onPressed: () => Navigator.pop(context)),
          backgroundColor: Colors.brown.shade200,
          centerTitle: true,
        ),
        body: !_isLoading
            ? Container(
                color: Colors.black,
                width: MediaQuery.of(context).size.width,
                height: double.infinity,
                child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (BuildContext context, int i) {
                      var icon;
                      if (i == 0) {
                        icon = Icon(Icons.grade_rounded,
                            color: Colors.yellow, size: 30.0);
                      } else if (i == 1) {
                        icon = Icon(Icons.grade_rounded,
                            color: Colors.grey.shade600, size: 30.0);
                      } else if (i == 2) {
                        icon = Icon(Icons.grade_rounded,
                            color: Colors.deepOrange.shade900, size: 30.0);
                      } else {
                        icon = Text("#" + (i + 1).toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.blueGrey));
                      }

                      return Container(
                        padding: const EdgeInsets.only(top: 10.0),
                        height: 100.0,
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 23.0, vertical: 3.0),
                          color: Colors.grey.shade900,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 24.0),
                                      child: icon),
                                  Container(
                                      margin: const EdgeInsets.all(16.0),
                                      child: Text(
                                        users[i]["name"].toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ],
                              ),
                              Container(
                                  margin: const EdgeInsets.only(right: 24.0),
                                  child: Text(
                                    users[i]["score"].toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  )),
                            ],
                          ),
                        ),
                      );
                    }),
              )
            : Container(
                color: Colors.black,
                child: Center(
                  child: CircularProgressIndicator(
                      color: Colors.white, strokeWidth: 5.0),
                ),
              ));
  }
}
