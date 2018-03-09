import 'dart:async';

import 'package:chatty/models/email_login_info.dart';
import 'package:chatty/models/serializers.dart';
import 'package:chatty/models/sign_up_info.dart';
import 'package:chatty/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
Firestore _db = Firestore.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();

class FirAuth {
  static final FirAuth instance = new FirAuth._internal();

  // TODO: magic string alert
  CollectionReference usersRef = _db.collection('users');

  factory FirAuth() {
    return instance;
  }

  FirAuth._internal();

  Future<void> pushUserInfo(FirebaseUser firebaseUser) async {
    User user = new User((b) => b
      ..email = firebaseUser.email
      ..name = firebaseUser.displayName
      ..isAnonymous = false
      ..userUid = firebaseUser.uid
      ..profilePic = firebaseUser.photoUrl
      ..provider = firebaseUser.providerId);
    return _db.collection('users')
        .document(firebaseUser.uid)
        .setData(serializers.serializeWith(User.serializer, user), SetOptions.merge);
  }
}
