import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';

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
    alert = DateTime.now().add(const Duration(seconds: 10));
  }

  String formatDuration(Duration d) {
    String f(int n) {
      return n.toString().padLeft(2, '0');
    }

    // round up the remaining time to the nearest second
    d += const Duration(microseconds: 999999);
    return "${f(d.inMinutes)}:${f(d.inSeconds % 60)}";
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
            Icon(
              reached ? Icons.alarm_on : Icons.alarm,
              color: reached ? Colors.red : Colors.green,
              size: 25,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: !reached
                  ? TimerBuilder.periodic(const Duration(seconds: 1),
                      alignment: Duration.zero, builder: (context) {
                      // This function will be called every second until the alert time
                      var now = DateTime.now();
                      var remaining = alert.difference(now);
                      return Text(
                        formatDuration(remaining),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      );
                    })
                  : const Text(
                      'Timout',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
            )
          ],
        ),
      );
    });
  }
}
