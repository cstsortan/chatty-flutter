import 'package:flutter/material.dart';
import 'package:redux/chat.dart';
import 'services/fir_auth.dart';

final FirAuth _auth = FirAuth.instance;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    _auth.login();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.orangeAccent,
        title: new Text('Chatty'),
      ),
      body: new Container(child: new Chat()),
    );
  }
}