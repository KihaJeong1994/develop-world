import 'dart:async';

import 'package:develop_world/widgets/home/spinning_dwd.dart';
import 'package:develop_world/widgets/home/web_instancing_performance.dart';
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
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              WebglInstancingPerformance(fileName: 'gg'),
              SizedBox(
                height: 50,
              ),
              // WebGLDwd(fileName: 'dwd'),
              SpinningDwd(),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void controllSpinning() {
    controller.duration = Duration(milliseconds: 2000 ~/ speed);
    controller.repeat();
  }
}
