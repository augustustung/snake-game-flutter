import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:myapp/screens/home.dart';
import 'package:myapp/screens/rank.dart';

class Auth extends StatefulWidget {
  final double _score;
  Auth(this._score);
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool _loading = false;
  String name = "";

  @override
  Widget build(BuildContext context) {
    _submit() async {
      setState(() {
        _loading = true;
      });

      if (name.trim().length == 0) {
        setState(() {
          _loading = false;
        });

        return showDialog(
            context: context,
            builder: (_) =>
                AlertDialog(title: Text("Please enter your name!!")));
      }

      var url = Uri.parse(
          "https://flutter-app-b5379-default-rtdb.asia-southeast1.firebasedatabase.app/highScore.json");
      var response = await http.post(url,
          body: json.encode({"name": name, "score": widget._score}));
      if (response.statusCode != 200) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                title: Text('Something went wrong, check your connection!')));
      }

      setState(() {
        _loading = false;
      });
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
              elevation: 20,
              actions: [
                ElevatedButton(
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (BuildContext context) => HomeScreen())),
                    child: Text(
                      'Ok',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
              ],
              title: Text('Uploading completed!')));
    }

    return Container(
      padding: const EdgeInsets.only(top: 30.0),
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FractionallySizedBox(
              widthFactor: 0.7,
              child: Container(
                child: Material(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  child: TextField(
                    autofocus: true,
                    textAlign: TextAlign.center,
                    maxLength: 16,
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.red,
                        fontWeight: FontWeight.bold),
                    onChanged: (val) {
                      setState(() {
                        name = val;
                      });
                    },
                    keyboardType: TextInputType.streetAddress,
                    decoration: InputDecoration(
                        focusedBorder: null,
                        hintText: 'Aa',
                        hintStyle: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w400)),
                  ),
                ),
              )),
          FractionallySizedBox(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              margin: const EdgeInsets.only(top: 20.0),
              width: MediaQuery.of(context).size.width * 0.3,
              height: 70,
              child: _loading
                  ? ElevatedButton(
                      onPressed: null,
                      child: CircularProgressIndicator(
                        strokeWidth: 3.0,
                        color: Colors.purple,
                      ))
                  : ElevatedButton(
                      onPressed: _submit,
                      child: Text("Save",
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.purple,
                              fontWeight: FontWeight.bold)),
                    ),
            ),
          )
        ],
      ),
    );
  }
}
