import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SnakeGame(),
  ));
}

class SnakeGame extends StatefulWidget {
  @override
  _SnakeGameState createState() => _SnakeGameState();
}

class _SnakeGameState extends State<SnakeGame> {
  List<int> snakeDots = [305];
  int numSquared = 760;

  //start game
  void _startGame() {
      snakeDots = [305];
    const duration = const Duration(milliseconds: 300);
    Timer.periodic(duration, (Timer timer) {
      _upDate();
      if (_isGameOver()) {
        timer.cancel();
        _showAlert();
      }
    });
  }

  void _clickWithoutFeedBack() {
    snakeDots = [305];
  }

  //food
  static var random = Random();
  int food = random.nextInt(700);
  void _generateNewFood() {
    food = random.nextInt(700);
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
          newDot = snakeDots.last - 20 + 740;
        else
          newDot = snakeDots.last - 20;
        break;
      case "down":
        if (snakeDots.last > 740)
          newDot = snakeDots.last + 20 - 740;
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
    // return isGameOver;
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

  //alert if lose
  _showAlert() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: ListTile(
              title: Text(
                "You Lose!",
                textAlign: TextAlign.center,
              ),
              subtitle: Text("Your score is: ${snakeDots.length}"),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _textAlertButton("Play Again", () {
                    _startGame();
                    Navigator.of(context).pop();
                  }),
                  _textAlertButton("Later", () {
                    _clickWithoutFeedBack();
                    Navigator.of(context).pop();
                  }),
                  _textAlertButton("View Rank", () {}),
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
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
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
            color: Colors.black,
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
                  }
                  return Container();
                }),
          ),
        )),
        Container(
          color: Colors.black,
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                onTap: _startGame,
                child: _text("S T A R T"),
              ),
              _text("@ a  u  g  u  s  t  u  s  f  l  y  n  n")
            ],
          ),
        )
      ]),
    );
  }

  _text(String text) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 10.0, color: Colors.white, fontWeight: FontWeight.bold),
    );
  }
}
