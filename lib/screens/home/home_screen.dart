import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  double spinTime = 5;
  double speed = 11;
  bool isSpinning = true;
  late AnimationController controller = AnimationController(
    duration: Duration(milliseconds: 2000 ~/ speed),
    vsync: this,
  );
  late Animation<double> animation =
      CurvedAnimation(parent: controller, curve: Curves.linear);
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        if (spinTime > 0) {
          spinTime -= 0.5;
          if (speed >= 2) {
            speed -= 1;
          }
          controllSpinning();
        }
      });
    });
    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    if (spinTime <= 0) {
      timer.cancel();
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RotationTransition(
              turns: animation,
              child: Text(
                'D.W.D',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize:
                      MediaQuery.of(context).size.width >= 800 ? 200 : 100,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            const SizedBox(
              height: 200,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      speed++;
                      isSpinning = true;
                      controllSpinning();
                    });
                  },
                  child: const Icon(Icons.arrow_circle_up_rounded),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (speed >= 2) {
                        speed--;
                        isSpinning = true;
                        controllSpinning();
                      }
                    });
                  },
                  child: const Icon(Icons.arrow_circle_down_rounded),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (isSpinning) {
                        controller.stop();
                      } else {
                        controller.repeat();
                        // controllSpinning();
                      }
                      isSpinning = !isSpinning;
                    });
                  },
                  child: isSpinning
                      ? const Icon(Icons.stop)
                      : const Icon(Icons.play_arrow),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void controllSpinning() {
    controller.duration = Duration(milliseconds: 2000 ~/ speed);
    controller.repeat();
  }
}
