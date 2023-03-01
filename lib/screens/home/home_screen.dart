import 'package:develop_world/widgets/home/web_instancing_performance.dart';
import 'package:flutter/material.dart';
import 'package:seo/seo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double spinTime = 5;
  double speed = 11;
  bool isSpinning = true;
  // late AnimationController controller = AnimationController(
  //   duration: Duration(milliseconds: 2000 ~/ speed),
  //   vsync: this,
  // );
  // late Animation<double> animation =
  //     CurvedAnimation(parent: controller, curve: Curves.linear);
  // late Timer timer;

  @override
  void initState() {
    super.initState();
    // timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
    //   setState(() {
    //     if (spinTime > 0) {
    //       spinTime -= 0.5;
    //       if (speed >= 2) {
    //         speed -= 1;
    //       }
    //       controllSpinning();
    //     }
    //   });
    // });
    // controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    if (spinTime <= 0) {
      // timer.cancel();
    }
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                child: MediaQuery.of(context).size.width >= 800
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Flexible(
                              child: Image(
                                  image:
                                      AssetImage('images/icons/dwd-192.png'))),
                          Flexible(child: SiteIntroText()),
                        ],
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Flexible(
                              child: Image(
                                  image:
                                      AssetImage('images/icons/dwd-192.png'))),
                          Flexible(child: SiteIntroText()),
                        ],
                      ),
              ),
              const SizedBox(
                height: 10,
              ),
              const WebglInstancingPerformance(fileName: 'gg'),
              // SizedBox(
              //   height: 50,
              // ),
              // WebGLDwd(fileName: 'dwd'),
              // SpinningDwd(),
              // SizedBox(
              //   height: 50,
              // ),
            ],
          ),
        ),
      ),
    );
  }

  // void controllSpinning() {
  //   controller.duration = Duration(milliseconds: 2000 ~/ speed);
  //   controller.repeat();
  // }
}

class SiteIntroText extends StatelessWidget {
  const SiteIntroText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Seo.text(
      text:
          'D.W.D는 Develop World by Develop의 약자로,\n \'개발로 세상을 발전시키자\'라는 취지로 만들어진 사이트입니다.\n\n현재 제공하는 기능은 \n\n1. 개발 공부를 위한 인강 비교 \n\n',
      child: RichText(
        text: const TextSpan(
          style: TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: 'D.W.D',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            TextSpan(
              text:
                  '는 Develop World by Develop의 약자로,\n \'개발로 세상을 발전시키자\'라는 취지로 만들어진 사이트입니다.\n\n',
            ),
            TextSpan(
              text: '현재 제공하는 기능은 \n\n',
            ),
            TextSpan(
              text: '1. 개발 공부를 위한 인강 비교 \n\n',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: '입니다. \n\n',
            ),
            TextSpan(
              text: '앞으로 계속 기능을 추가할 예정이며, \n',
            ),
            TextSpan(
              text: '문의를 통해 많은 의견 공유 부탁드립니다.',
            ),
          ],
        ),
      ),
    );
  }
}
