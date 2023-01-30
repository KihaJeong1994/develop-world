import 'package:develop_world/widgets/lecture/lecture_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
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
    switch (_selectedIndex) {
      case 0:
        page = const LectureList();
        break;
      case 1:
        page = const Placeholder();
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
          style: const TextStyle(
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
