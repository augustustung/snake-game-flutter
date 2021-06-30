import 'package:flutter/material.dart';
import 'rank.dart';
import 'snake_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userAction = "choosing";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.only(top: 20.0),
            child: _textCustom("S   N   A   K   E", 30.0, FontWeight.bold),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _textCustom("W e l l  c o m e  t o  s n a k e  g a m e", 14.0,
                      FontWeight.w600),
                  SizedBox(height: 20.0),
                  userAction == "choosing"
                      ? Container(
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.symmetric(vertical: 30.0),
                          child: IconButton(
                            hoverColor: Colors.deepOrange,
                            onPressed: () {
                              setState(() {
                                userAction = "choosed";
                              });
                            },
                            icon: Icon(Icons.play_arrow_sharp),
                            iconSize: 60.0,
                            alignment: Alignment.center,
                            color: Colors.white,
                          ),
                        )
                      : Column(
                          children: <Widget>[
                            _buttonCustom("HARD", 15.0, FontWeight.bold,
                                Colors.red, "hard"),
                            _buttonCustom("MEDIUM", 15.0, FontWeight.bold,
                                Colors.red.shade400, "medium"),
                            _buttonCustom("EASY", 15.0, FontWeight.bold,
                                Colors.green, "easy"),
                          ],
                        ),
                  SizedBox(height: 20.0),
                  Material(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.amber.shade400,
                    shadowColor: Colors.white,
                    elevation: 5.0,
                    child: InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Rank())),
                      child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child:
                              _textCustom("View Rank", 16.0, FontWeight.bold)),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            margin: const EdgeInsets.only(right: 10.0),
            child: Text("@ a  u  g  u  s  t  u  s      f  l  y  n  n",
                style: TextStyle(fontSize: 12.0, color: Colors.white)),
          )
        ],
      ),
    );
  }

  _textCustom(String text, double fontsize, fontweight) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: fontweight,
          fontFamily: "Pixel",
          fontSize: fontsize,
          color: Colors.white),
    );
  }

  _buttonCustom(
      String text, double fontsize, fontweight, Color color, String level) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Material(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: fontweight,
                    fontFamily: "Pixel",
                    fontSize: fontsize,
                    color: color),
              ),
            ),
            onTap: () => _hanledPress(level),
          )),
    );
  }

  _hanledPress(String level) {
    Duration _duraiton;
    double mode;
    if (level == "hard") {
      _duraiton = const Duration(milliseconds: 150);
      mode = 2.0;
    } else if (level == "medium") {
      _duraiton = const Duration(milliseconds: 300);
      mode = 1.0;
    } else {
      _duraiton = const Duration(milliseconds: 500);
      mode = 0.5;
    }
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SnakeGame(_duraiton, mode)));
  }
}
