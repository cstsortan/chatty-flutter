import 'dart:async';
import 'dart:io';

import 'package:chatty/data/services/fir_chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'main.dart';

class Chat extends StatelessWidget {
  final String userUid;
  Chat(this.userUid);
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<List<DocumentSnapshot>>(
      stream: FirChat.instance.getUsers(userUid),
      builder: (context, snap) {
        List<DocumentSnapshot> docs = snap.data ?? <DocumentSnapshot>[];
        print(snap.toString());
        return new ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, i) {
            final String contactUid = docs[i]?.data['userUid'];
            final String name = docs[i]?.data['name'] ?? '';
            final String profilePic = docs[i]?.data['profilePic'] ?? ' ';
            return new ListTile(
              leading: new CircleAvatar(
                child: profilePic == ''
                    ? new Text(
                        name[0],
                      )
                    : new Material(
                        type: MaterialType.circle,
                        child: new CachedNetworkImage(
                          imageUrl: profilePic,
                          placeholder: new CircularProgressIndicator(),
                          errorWidget: new Icon(Icons.error),
                        ),
                        color: Colors.white,
                      ),
              ),
              title: new Text(name),
              onTap: () {
                defineRoutes(router);
                router.navigateTo(context, "/contactsChat/$userUid/$contactUid",
                    transition: TransitionType.native);
              },
            );
          },
        );
      },
    );
  }
}

class RecentChats extends StatelessWidget {
  final String userUid;
  RecentChats(this.userUid);
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<List<DocumentSnapshot>>(
      stream: FirChat.instance.getRecentChats(userUid),
      builder: (context, snaps) {
        final List<DocumentSnapshot> recentChats = snaps.data ?? [];
        if (recentChats.isEmpty)
          return new Center(
            child: new Text('No conversations yet!'),
          );
        return new ListView.builder(
          itemCount: recentChats.length,
          itemBuilder: (context, i) {
            final String author = recentChats[i].data['authorUid'];
            final String contact = recentChats[i].documentID;
            final String text = recentChats[i].data['text'];
            final String photo = recentChats[i].data['photoUrl'];
            return new ListTile(
              title: new Text(contact),
              subtitle: new Text(
                  '${author==contact?'':'You: '}${photo==''?text:'A photo was sent'}'),
              leading: new CircleAvatar(
                child: new Text(contact[0]),
              ),
              onTap: () {
                defineRoutes(router);
                router.navigateTo(context, "/contactsChat/$userUid/$contact",
                    transition: TransitionType.native);
              },
            );
          },
        );
      },
    );
  }
}

class PrivateChat extends StatelessWidget {
  final TextEditingController _textController = new TextEditingController();
  PrivateChat(this.contactUid, this.userUid);
  final String userUid;
  final String contactUid;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(contactUid),
      ),
      body: new StreamBuilder<List<DocumentSnapshot>>(
        stream: FirChat.instance.getPrivateMessagesWith(contactUid, userUid),
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
                    final String sender = docs[i].data['authorUid'];
                    final String text = docs[i].data['text'];
                    final String photo = docs[i].data['photoUrl'];
                    return new Column(
                      children: <Widget>[
                        new ListTile(
                          leading: new CircleAvatar(
                            child: new Text(sender[0]),
                          ),
                          title: photo == ''
                              ? new Text(text)
                              : new Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: new CachedNetworkImage(
                                    imageUrl: photo,
                                    placeholder: new Center(
                                        child: new CircularProgressIndicator()),
                                    errorWidget: new Icon(Icons.error),
                                  ),
                                ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              new Row(
                children: <Widget>[
                  new IconButton(
                    icon: new Icon(Icons.image),
                    color: Colors.blue,
                    onPressed: () async {
                      File file = await ImagePicker.pickImage(
                          source: ImageSource.askUser);

                      FirChat.instance.sendPhoto(contactUid, file);
                    },
                  ),
                  new Flexible(
                    flex: 1,
                    child: new Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: new TextField(
                        controller: _textController,
                        decoration:
                            const InputDecoration(hintText: 'Enter a message'),
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
      ),
    );
  }
}
