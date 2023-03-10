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
          'D.W.D??? Develop World by Develop??? ?????????,\n \'????????? ????????? ???????????????\'?????? ????????? ???????????? ??????????????????.\n\n?????? ???????????? ????????? \n\n1. ?????? ????????? ?????? ?????? ?????? \n\n',
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
                  '??? Develop World by Develop??? ?????????,\n \'????????? ????????? ???????????????\'?????? ????????? ???????????? ??????????????????.\n\n',
            ),
            TextSpan(
              text: '?????? ???????????? ????????? \n\n',
            ),
            TextSpan(
              text: '1. ?????? ????????? ?????? ?????? ?????? \n\n',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: '?????????. \n\n',
            ),
            TextSpan(
              text: '????????? ?????? ????????? ????????? ????????????, \n',
            ),
            TextSpan(
              text: '????????? ?????? ?????? ?????? ?????? ??????????????????.',
            ),
          ],
        ),
      ),
    );
  }
}
