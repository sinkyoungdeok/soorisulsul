import 'package:flutter/material.dart';
import 'package:soorisulsul/screen/first.dart';
import 'package:soorisulsul/screen/home.dart';
import 'package:soorisulsul/screen/second.dart';


class Main extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _children = [Home(), First(), Second(), Second()];
  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: _onTap,
            currentIndex: _currentIndex,
            items: [
              new BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('홈'),
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.work_outlined),
                title: Text('마켓'),
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.article),
                title: Text('커뮤니티'),
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.wb_incandescent_rounded),
                title: Text('정보'),
              )
            ]));
  }
}
