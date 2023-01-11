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
        primarySwatch: Colors.lime,
      ),
      home: const MyHomePage(title: 'Develop World'),
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
  bool _extended = true;

  void _setSelectedIndex(int value) {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _selectedIndex = value;
    });
  }

  void _setExtended() {
    setState(() {
      _extended = !_extended;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    final ButtonStyle style = TextButton.styleFrom(
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
    );
    Widget page;
    switch (_selectedIndex) {
      case 0:
        page = Center(
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1 / 1,
              // mainAxisSpacing: 0.1,
              // crossAxisSpacing: 0.1,
            ),
            children: [
              for (var num in [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13])
                Column(
                  children: [
                    Image.asset(
                        'assets/images/lectures/lecture1.png'), // chrome & macos path is different
                    Text(
                      '${num.toString()} 번째 인강',
                    )
                  ],
                ),
              // ListTile(
              //   title: Text(
              //     '${num.toString()} 번째 인강',
              //   ),
              // )
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
    IconData arrowIconData;
    arrowIconData =
        _extended ? Icons.arrow_back_ios_new : Icons.arrow_forward_ios;
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
        title: Text(widget.title),
        centerTitle: false,
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return Row(
          children: [
            SafeArea(
              child: NavigationRail(
                leading: IconButton(
                  onPressed: (() => _setExtended()),
                  icon: Icon(arrowIconData),
                ),
                extended: _extended,
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
                onDestinationSelected: (value) => _setSelectedIndex(value),
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
