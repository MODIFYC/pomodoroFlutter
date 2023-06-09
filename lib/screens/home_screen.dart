import 'dart:async';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int totalSeconds = 1500;
  bool isRunning = false;
  int totalPomodoros = 0;
  int totalCycles = 0;
  int selectedTime = 25;
  bool isResting = false;
  int restTime = 300;
  late Timer timer;

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      if (isResting) {
        setState(() {
          isResting = false;
          totalSeconds = selectedTime * 60;
          if (totalCycles % 4 == 0) {
            // 한 번의 사이클(4개의 라운드)이 끝난 경우
            restTime = 300;
          } else {
            // 사이클 중인 경우
            restTime = 0;
          }
        });
      } else {
        setState(() {
          totalPomodoros = totalPomodoros + 1;
          totalSeconds = restTime;
          isResting = true;
          if (isResting && totalCycles % 4 == 0) {
            totalCycles = totalCycles + 1;
          }
        });
      }
    } else {
      setState(() {
        totalSeconds = totalSeconds - 1;
      });
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(Duration(seconds: 1), onTick);
    setState(() {
      isRunning = true;
    });
  }

  void onPausPressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onResetPressed() {
    timer.cancel();
    setState(() {
      totalSeconds = selectedTime * 60;
      isRunning = false;
    });
  }

  void onTimeSelected(int time) {
    timer.cancel();
    setState(() {
      selectedTime = time;
      totalSeconds = selectedTime * 60;
      isRunning = false;
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split('.').first.substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,

      body: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: EdgeInsets.all(8.0),
              margin: EdgeInsets.only(left: 16.0, top: 8.0),
              child: Text(
                'POMOTIMER',
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Column(
              children: [

                SizedBox(height: 20),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    format(totalSeconds),
                    style: TextStyle(
                      color: Theme.of(context).cardColor,
                      fontSize: 89,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.white),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                      ),
                      onPressed: () => onTimeSelected(15),
                      child: Text('15', style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(width: 10),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.white),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                      ),
                      onPressed: () => onTimeSelected(20),
                      child: Text('20', style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(width: 10),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.white),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                      ),
                      onPressed: () => onTimeSelected(25),
                      child: Text('25', style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(width: 10),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.white),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                      ),
                      onPressed: () => onTimeSelected(30),
                      child: Text('30', style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(width: 10),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.white),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                      ),
                      onPressed: () => onTimeSelected(35),
                      child: Text('35', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),

          ),
          Flexible(
            flex: 2,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 120,
                    color: Theme.of(context).cardColor,
                    onPressed: isRunning ? onPausPressed : onStartPressed,
                    icon: Icon(isRunning
                        ? Icons.pause_circle_outline
                        : Icons.play_circle_outlined),
                  ),
                  IconButton(
                    onPressed: onResetPressed,
                    iconSize: 50,
                    color: Theme.of(context).cardColor,
                    icon: Icon(Icons.refresh),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ROUND',
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).textTheme.displayLarge?.color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '$totalCycles',
                          style: TextStyle(
                            fontSize: 58,
                            color: Theme.of(context).textTheme.displayLarge?.color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'GOAL',
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).textTheme.displayLarge?.color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '$totalPomodoros',
                          style: TextStyle(
                            fontSize: 58,
                            color: Theme.of(context).textTheme.displayLarge?.color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}