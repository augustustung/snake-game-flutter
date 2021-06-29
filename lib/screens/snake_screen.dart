import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myapp/provider/auth.dart';
import 'package:myapp/screens/rank.dart';

import 'home.dart';
// import 'package:myapp/provider/provider.dart';

class SnakeGame extends StatefulWidget {
  static const routeName = '/snake';
  final Duration _duration;
  final double _mode;
  SnakeGame(this._duration, this._mode);
  @override
  _SnakeGameState createState() => _SnakeGameState(_duration, _mode);
}

class _SnakeGameState extends State<SnakeGame> {
  final Duration _duration;
  final double _mode;
  _SnakeGameState(this._duration, this._mode);
  List<int> snakeDots = [205];
  int numSquared = 560;

  //start game
  void _startGame() {
    snakeDots = [205, 225, 245, 265, 285, 305, 325, 345, 365, 385, 405];
    Timer.periodic(_duration, (Timer timer) {
      _upDate();
      if (_isGameOver()) {
        timer.cancel();
        _showAlert();
      }
    });
  }

  void _clickWithoutFeedBack() {
    setState(() {
      snakeDots = [205];
      direction = "left";
    });
  }

  //food
  static var random = Random();
  int food = random.nextInt(450);
  void _generateNewFood() {
    food = random.nextInt(450);
  }

  //move direction
  var direction = "right";
  void _moveSnake() {
    int newDot = 0;
    switch (direction) {
      case "left":
        if (snakeDots.last % 20 == 0)
          newDot = snakeDots.last - 1 + 20;
        else
          newDot = snakeDots.last - 1;
        break;
      case "right":
        if ((snakeDots.last + 1) % 20 == 0)
          newDot = snakeDots.last + 1 - 20;
        else
          newDot = snakeDots.last + 1;
        break;
      case "up":
        if (snakeDots.last < 20)
          newDot = snakeDots.last - 20 + 540;
        else
          newDot = snakeDots.last - 20;
        break;
      case "down":
        if (snakeDots.last > 560)
          newDot = snakeDots.last + 20 - 540;
        else
          newDot = snakeDots.last + 20;
        break;
      default:
    }
    //a copy of snake and set again
    var snakes = snakeDots;
    snakes.remove(snakes.first);
    snakes.add(newDot);
    setState(() {
      snakeDots = snakes;
    });
  }

  //check if eat
  void _checkIfEat() {
    var snakes = snakeDots;
    if (snakeDots.last == food) {
      snakes.insert(0, 999);
      _generateNewFood();
      setState(() {
        snakeDots = snakes;
      });
    }
  }

  //game action
  void _upDate() {
    _moveSnake();
    _checkIfEat();
  }

  //check lose
  bool _isGameOver() {
    for (int i = 0; i < snakeDots.length; i++) {
      int count = 0;
      for (int j = 0; j < snakeDots.length; j++) {
        if (snakeDots[i] == snakeDots[j]) {
          count++;
        }
      }
      if (count == 2) {
        return true;
      }
    }

    return false;
  }

  double _countScore() {
    if (_mode == 2.0)
      return snakeDots.length * 2.0;
    else if (_mode == 1.0) return snakeDots.length * 1.0;
    return snakeDots.length * 0.5;
  }

  //alert if lose
  _showAlert() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Column(
              children: <Widget>[
                Text(
                  "You Lose!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                Text(
                  "Your score is: ${_countScore()}",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13.0),
                ),
              ],
            ),
            actions: [
              Divider(thickness: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _textAlertButton("Play Again", () {
                    _startGame();
                    Navigator.of(context).pop();
                  }),
                  _textAlertButton("Later", () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => HomeScreen()));
                  }),
                  _textAlertButton(
                      "Upload score",
                      () => {
                            if (_countScore() < 10)
                              {
                                showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                        title: Text(
                                            "Reach at least 10 point to save!!")))
                              }
                            else
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Auth(_countScore())))
                          }),
                ],
              )
            ],
          );
        });
  }

  _textAlertButton(String text, onTap) {
    return InkWell(
      onTap: onTap,
      child: Text(text,
          style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w400)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        Expanded(
            child: GestureDetector(
          onHorizontalDragUpdate: (detail) {
            if (direction != "left" && detail.delta.dx > 0) {
              direction = "right";
            } else if (direction != "right" && detail.delta.dx < 0) {
              direction = "left";
            }
          },
          onVerticalDragUpdate: (detail) {
            if (direction != "up" && detail.delta.dy > 0) {
              direction = "down";
            } else if (direction != "down" && detail.delta.dy < 0) {
              direction = "up";
            }
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black,
                border: Border(
                    bottom:
                        BorderSide(width: 0.5, color: Colors.grey.shade900))),
            child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: numSquared,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 20),
                itemBuilder: (BuildContext context, int index) {
                  if (snakeDots.contains(index)) {
                    return Container(
                      padding: const EdgeInsets.all(2),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        child: Container(color: Colors.white),
                      ),
                    );
                  }
                  if (index == food) {
                    return Container(
                      padding: const EdgeInsets.all(2.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          child: Container(color: Colors.green)),
                    );
                  } else
                    return Container();
                }),
          ),
        )),
        Container(
          color: Colors.black,
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                onTap: _startGame,
                child: _text("S T A R T", 16.0),
              ),
              InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Rank())),
                  child: _text("V i e w R a n k", 13.7)),
              _text("@ a  u  g  u  s  t  u  s      f  l  y  n  n", 12.0)
            ],
          ),
        )
      ]),
    );
  }

  _text(String text, double fontSize) {
    return Text(
      text,
      style: TextStyle(
          fontSize: fontSize, color: Colors.white, fontWeight: FontWeight.bold),
    );
  }
}
