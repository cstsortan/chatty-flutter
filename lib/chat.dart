import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:redux/services/fir_auth.dart';
import 'package:redux/services/fir_chat.dart';

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<Stream<List<DocumentSnapshot>>>(
      future: FirChat.instance.getUsers(),
      builder: (_, contactsSnap) {
        return new StreamBuilder<List<DocumentSnapshot>>(
          stream: contactsSnap.data,
          builder: (context, snap) {
            final List<DocumentSnapshot> docs =
                snap.data ?? <DocumentSnapshot>[];
            if (docs.isEmpty)
              return const Center(
                child: const Text('No contacts'),
              );
            return new Container(
              child: new ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, i) {
                  final String contactUid = docs[i].data['userUid'];
                  return new ListTile(
                    title: new Text(contactUid),
                    onTap: () async {
                      if ((await FirebaseAuth.instance.currentUser())
                          .isAnonymous) {
                        FirAuth.instance.signInWithGoogle();
                      } else {
                        Navigator.of(context).push(
                            new MaterialPageRoute<Null>(builder: (context) {
                          return new PrivateChat(contactUid);
                        }));
                      }
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}

class PrivateChat extends StatelessWidget {
  final TextEditingController _textController = new TextEditingController();

  PrivateChat(this.contactUid);
  final String contactUid;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(contactUid),
      ),
      body: new FutureBuilder<Stream<List<DocumentSnapshot>>>(
        future: FirChat.instance.getPrivateMessagesWith(contactUid),
        builder: (_, observableSnap) {
          if (observableSnap?.data != null) {
            return new StreamBuilder<List<DocumentSnapshot>>(
              stream: observableSnap.data,
              builder: (_, snap) {
                final List<DocumentSnapshot> docs =
                    snap.data?.reversed?.toList() ?? [];
                final ScrollController _controller = new ScrollController(
                  keepScrollOffset: true,
                  initialScrollOffset: 0.0,
                );
                return new Column(
                  children: <Widget>[
                    new Expanded(
                      child: new ListView.builder(
                        reverse: true,
                        itemCount: docs.length,
                        controller: _controller,
                        itemBuilder: (_, i) {
                          final String seender = docs[i].data['authorUid'];
                          final String text = docs[i].data['text'];
                          return new ListTile(
                            leading: new CircleAvatar(
                              child: new Text(seender[0]),
                            ),
                            title: new Text(text),
                          );
                        },
                      ),
                    ),
                    new Row(
                      children: <Widget>[
                        new Flexible(
                          flex: 1,
                          child: new Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: new TextField(
                              controller: _textController,
                              decoration: const InputDecoration(
                                  hintText: 'Enter a message'),
                              onSubmitted: (String text) {
                                _textController.text = '';
                                FirChat.instance
                                    .sendMessageToContact(contactUid, text, '');
                              },
                            ),
                          ),
                        ),
                        new IconButton(
                          icon: new Icon(Icons.send),
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            FirChat.instance.sendMessageToContact(
                                contactUid, _textController.text, '');
                            _textController.text = '';
                          },
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          } else
            return new Center(
              child: new Text('Loading...'),
            );
        },
      ),
    );
  }
}
