import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:redux/services/fir_auth.dart';

class FirChat {
  static final FirChat instance = new FirChat._internal();
  static final Firestore _db = Firestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

// TODO: magic string alert
  final CollectionReference _privateChatCol = _db.collection('privatechats');
  // final CollectionReference _groupChats = _db.collection('chatrooms');
  // final CollectionReference _publicRooms = _db.collection('publicrooms');
  final CollectionReference _users = _db.collection('users');

  factory FirChat() {
    return instance;
  }

  FirChat._internal();

  // TODO: create model class for PrivateChatMessage
  // Emmits the list of messages exchanged privately with
  // some other user (contact).
  Future<Stream<List<DocumentSnapshot>>> getPrivateMessagesWith(
      String contactUid) async {
    final FirebaseUser user = await _auth.currentUser();
    return _privateChatCol
            .document(user.uid)
            .getCollection('chats')
            .document(contactUid)
            .getCollection('messages')
            .snapshots
        .map<List<DocumentSnapshot>>((snap) => snap.documents);
  }

  // // TODO: create model class for GroupChat
  // // Emmits the list of chatrooms where this
  // // user is a member.
  // Stream<QuerySnapshot> getGroupChats() {
  //   return _user.flatMap((user) {
  //     return _groupChats
  //         .where('members.${user.uid}', isEqualTo: true)
  //         .snapshots;
  //   });
  // }

  // TODO: create model class for GroupChatMessage
  // // Emmits the list of messages exchanged in a chat room
  // Observable<QuerySnapshot> getMessagesForGroupChat(String groupChatId) {
  //   return _groupChats
  //       .document(groupChatId)
  //       .getCollection('messages')
  //       .orderBy('timestamp')
  //       .snapshots;
  // }

  // // Emmits the list of Public rooms available to all users
  // // TODO: create model class for PublicChatRoom
  // Observable<QuerySnapshot> getPublicRooms() {
  //   return _publicRooms.snapshots;
  // }

  // // TODO: create model class for PublicRoomMessage
  // // Emmits the list of messages exchanged in a public chat room
  // Observable<QuerySnapshot> getMessagesForPublicRoom(String publicRoomId) {
  //   return _publicRooms
  //       .document(publicRoomId)
  //       .getCollection('messages')
  //       .snapshots;
  // }

  // Observable<QuerySnapshot> getChats() {
  //   return _user.flatMap((user) {});
  // }

  // TODO: replace with data model
  // TODO: add photo field
  Future<Null> sendMessageToContact(
      String contactUid, String text, String photoUrl) async {
    // TODO: Delete when real auth is implemented
    await _auth.signInAnonymously();

    final FirebaseUser user = await _auth.currentUser();
    final Map<String, dynamic> message = <String, dynamic>{
      'text': text ?? '',
      'photoUrl': photoUrl ?? '',
      'authorUid': contactUid,
    };

    final Future<Null> f1 = _privateChatCol
        .document(user.uid)
        .getCollection('chats')
        .document(contactUid)
        .getCollection('messages')
        .document()
        .setData(message);

    final Future<Null> f2 = _privateChatCol
        .document(contactUid)
        .getCollection('chats')
        .document(user.uid)
        .getCollection('messages')
        .document()
        .setData(message);

    // This will work at least until batched writes
    // are available so it's guaranteed both the sender
    // and the receiver have the same exact message
    // persisted "locally".
    await Future.wait<Null>(<Future<Null>>[f1, f2]);
    return null;
  }

  Future<Stream<List<DocumentSnapshot>>> getUsers() async {
    final FirebaseUser user = await _auth.currentUser();
    if (user == null) return new Stream.fromIterable([]);
    return _users.snapshots.map<List<DocumentSnapshot>>((snap) {
      return snap.documents..removeWhere((s) => s.data['userUid'] == user.uid);
    });
  }
}