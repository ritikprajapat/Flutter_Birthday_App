import 'dart:async';

import 'package:birthday_app/birthday.dart';
import 'package:birthday_app/home_view.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TimerView extends StatefulWidget {
  final Birthday birthday;
Riti
  const TimerView({
    Key? key,
    required this.birthday,
  }) : super(key: key);

  @override
  _TimerViewState createState() => _TimerViewState();
}

class _TimerViewState extends State<TimerView> {
  late Timer timer;
  late String countdown;
  bool isPlaying = false;
  final controller = ConfettiController();
  @override
  void initState() {
    super.initState();
    countdown = _convertDateToDurationString(widget.birthday.dob.toString());
    _startTimer();

    controller.addListener(() {
      isPlaying = controller.state == ConfettiControllerState.playing;
      setState(() {});
    });
  }

  void _startTimer() {
    const oneSecond = Duration(seconds: 1);
    timer = Timer.periodic(oneSecond, (Timer t) {
      _updateTimeRemaining(widget.birthday.dob.toString());
    });
  }

  void _updateTimeRemaining(String inputDate) {
    String remainingTime = _convertDateToDurationString(inputDate);
    setState(() {
      countdown = remainingTime;
    });
  }

  String _convertDateToDurationString(String inputDate) {
    List<String> dateComponents = inputDate.split('/');

    if (dateComponents.length != 3) {
      return "Invalid date format";
    }

    int? day = int.tryParse(dateComponents[0]);
    int? month = int.tryParse(dateComponents[1]);
    int? year = int.tryParse(dateComponents[2]);

    if (day == null || month == null || year == null) {
      return "Invalid date format";
    }

    DateTime inputDateTime = DateTime(year, month, day);
    DateTime now = DateTime.now();

    Duration duration = inputDateTime.isAfter(now) ? inputDateTime.difference(now) : Duration.zero;

    int days = duration.inDays;
    int hours = duration.inHours % 24;
    int minutes = duration.inMinutes % 60;
    int seconds = duration.inSeconds % 60;

    return "$days, $hours, $minutes, $seconds";
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    bool isTimerZero = countdown != "0, 0, 0, 0";
    return Scaffold(
      body: Container(
        color: Colors.pinkAccent,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Container(
                color: Colors.white,
                child: Lottie.network(
                  isTimerZero
                      ? 'https://lottie.host/1a908d51-e60f-4a8a-bd63-570cc40d7955/kYEgn5qgur.json'
                      : 'https://lottie.host/149e1bb9-f4fc-4e8e-b9f0-540ffa6c3b87/BZ2Geg1Otk.json',
                  width: 180,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 12),
            Text(
              '${widget.birthday.name}, you have a Surprise!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTimeColumn(countdown.split(',')[0], 'Days'),
                    Text(':'),
                    _buildTimeColumn(countdown.split(',')[1], 'Hours'),
                    Text(':'),
                    _buildTimeColumn(countdown.split(',')[2], 'Minutes'),
                    Text(':'),
                    _buildTimeColumn(countdown.split(',')[3], 'Seconds'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12),
            GestureDetector(
              onTap: isTimerZero
                  ? null
                  : () {
                      controller.play();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeView(
                            controller: controller,
                            birthday: widget.birthday,
                          ),
                        ),
                      );
                    },
              child: Container(
                height: 48,
                width: 180,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: isTimerZero ? Colors.red : Colors.green,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.redeem,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8),
                    isTimerZero
                        ? Text(
                            'Close',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Text(
                            'Open',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _buildTimeColumn(String time, String unit) {
    return Column(
      children: [
        Text(
          time,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.redAccent,
          ),
        ),
        Text(
          unit,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
