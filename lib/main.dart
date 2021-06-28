import 'package:flutter/material.dart';
import 'package:myapp/game_screen/snake_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userAction = "choosing";
  int duration = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(16.0),
              child: _textCustom("S   N   A   K   E", 30.0, FontWeight.bold),
            ),
            Expanded(
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _textCustom("Well come to snake game", 18.0, FontWeight.w600),
                  SizedBox(height: 20.0),
                  userAction == "choosing"
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              userAction = "choosed";
                            });
                          },
                          icon: Icon(Icons.play_arrow_sharp),
                          iconSize: 60.0,
                          alignment: Alignment.center,
                          color: Colors.white,
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
                        )
                ],
              )),
            ),
            Container(
              alignment: Alignment.bottomRight,
              margin: const EdgeInsets.only(right: 10.0),
              child: Text("@ a  u  g  u  s  t  u  s      f  l  y  n  n",
                  style: TextStyle(fontSize: 12.0, color: Colors.white)),
            )
          ],
        ));
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
    if (level == "hard") {
      duration = 200;
    } else if (level == "medium") {
      duration = 300;
    } else {
      duration = 500;
    }

    print(duration);
  }
}
