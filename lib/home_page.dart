import 'package:flutter/material.dart';
import 'chat.dart';
import 'splash_page.dart';

class HomePage extends StatefulWidget {
  final String userUid;
  HomePage(this.userUid);
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.orangeAccent,
        title: new Text('Chatty'),
        actions: <Widget>[
          new FlatButton(
            child: new Text('logout', style: new TextStyle(
              color: Colors.white,
            ),),
            onPressed: () {
              Navigator.pushReplacement(context, new MaterialPageRoute(
                    builder: (context) => new SplashPage()
                  ));
            },
          ),
        ],
      ),
      body: new Container(
        child: new Center(child: new RecentChats(widget.userUid)),
      ),
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            new Expanded(child: new Chat(widget.userUid)),
          ],
        ),
      ),
    );
  }
}
