import 'package:develop_world/lecture.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(
        title: 'D.W.D',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = TextButton.styleFrom(
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
    );
    Widget page;
    var lectures = [
      Lecture(
        title: '스프링 입문 - 코드로 배우는 스프링 부트, 웹 MVC, DB 접근 기술',
        site: Site.inflearn,
        image: 'lecture1.png',
      ),
      Lecture(
        title: '10개 프로젝트로 완성하는 백엔드 웹개발(Java/Spring)',
        site: Site.fastcampus,
        image: 'lecture2.png',
      ),
      Lecture(
        title: '[코드팩토리] [입문] Dart 언어 4시간만에 완전정복',
        site: Site.inflearn,
        image: 'lecture3.png',
      ),
    ];
    switch (_selectedIndex) {
      case 0:
        page = Center(
          child: GridView(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 320,
              childAspectRatio: 400 / 400,
            ),
            children: [
              for (var lecture in lectures)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.asset(
                        'images/lectures/${lecture.image}',
                        width: 320,
                        height: 160,
                      ), // chrome & macos path is different
                      Table(
                        border: TableBorder.all(
                          style: BorderStyle.none,
                        ),
                        columnWidths: const <int, TableColumnWidth>{
                          0: FixedColumnWidth(100),
                          1: FlexColumnWidth(),
                        },
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: <TableRow>[
                          TableRow(
                            children: <Widget>[
                              Container(
                                height: 32,
                                child: Text(
                                  '제목',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.top,
                                child: Container(
                                  height: 40,
                                  child: Text(
                                    '${lecture.title}',
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: <Widget>[
                              Container(
                                height: 32,
                                child: Text(
                                  '사이트',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ),
                              Container(
                                height: 32,
                                child: Text('${lecture.site.name}'),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
            ],
          ),
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //     const Text(
          //       '인강 리스트 불러오기',
          //     ),
          //   ],
          // ),
        );
        break;
      case 1:
        page = Placeholder();
        break;
      default:
        throw UnimplementedError('No page for $_selectedIndex');
    }
    // IconData arrowIconData;
    // arrowIconData =
    //     _extended ? Icons.arrow_back_ios_new : Icons.arrow_forward_ios;
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.accessibility_new_rounded),
        actions: <Widget>[
          TextButton(
            style: style,
            onPressed: (() {}),
            child: TextButton.icon(
                onPressed: (() {}),
                style: TextButton.styleFrom(foregroundColor: Colors.black),
                icon: const Icon(Icons.login),
                label: const Text('로그인')),
          )
        ],
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          widget.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: false,
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 600,
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.computer),
                    label: Text('인강'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.mail),
                    label: Text('문의'),
                  ),
                ],
                selectedIndex: _selectedIndex,
                onDestinationSelected: (value) =>
                    setState(() => _selectedIndex = value),
              ),
            ),
            Expanded(
              child: Container(
                child: page,
              ),
            ),
          ],
        );
      }),
    );
  }
}
