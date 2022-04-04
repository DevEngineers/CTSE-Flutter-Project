import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';

//Reference : https://flutteragency.com/how-to-create-timer-in-flutter/
class CountDownTimer extends StatefulWidget {
  final Function? callback;
  const CountDownTimer({Key? key, this.callback}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CountDownTimer();
}

class _CountDownTimer extends State<CountDownTimer> {
  late DateTime alert;

  @override
  void initState() {
    super.initState();
    alert = DateTime.now().add(const Duration(seconds: 300));
    Future.delayed(const Duration(seconds: 300), () => widget.callback!());
  }

  String formatDuration(Duration duration) {
    String formatTime(int time) {
      return time.toString().padLeft(2, '0');
    }

    // round up the remaining time to the nearest second
    duration += const Duration(microseconds: 999999);
    return "${formatTime(duration.inMinutes)}:${formatTime(duration.inSeconds % 60)}";
  }

  @override
  Widget build(BuildContext context) {
    return TimerBuilder.scheduled([alert], builder: (context) {
      DateTime now = DateTime.now();
      final reached = now.compareTo(alert) >= 0;

      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 20, 0, 0),
              child: Icon(
                reached ? Icons.alarm_on : Icons.alarm,
                color: reached ? Colors.red : Colors.green,
                size: 25,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 20, 8, 0),
              child: !reached
                  ? TimerBuilder.periodic(const Duration(seconds: 1),
                      alignment: Duration.zero, builder: (context) {
                      // This function will be called every second until the alert time
                      var now = DateTime.now();
                      var remaining = alert.difference(now);
                      return Text(
                        '${formatDuration(remaining)} min',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      );
                    })
                  : const Text(
                      '00:00',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
            )
          ],
        ),
      );
    });
  }
}
