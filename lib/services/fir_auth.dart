import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
Firestore _db = Firestore.instance;
final GoogleSignIn _gSignIn = new GoogleSignIn();

class FirAuth {
  static final FirAuth instance = new FirAuth._internal();

  // TODO: magic string alert
  CollectionReference usersRef = _db.collection('users');

  factory FirAuth() {
    return instance;
  }

  FirAuth._internal();

  Future<FirebaseUser> login() async {
    FirebaseUser currentUser = await _auth.currentUser();
    if (currentUser == null) {
      FirebaseUser user = await _auth.signInAnonymously();
      return _db.collection('users').document(user.uid).setData({
        'userUid': user.uid,
        'isAnonymous': true,
        'provider': user.providerId,
      }, SetOptions.merge);
    } else return currentUser;
  }

  // Future<Null> register() async {
  //   final FirebaseUser firebaseUser = await _auth.createUserWithEmailAndPassword(
  //     email: info.email,
  //     password: info.password,
  //   );

  //   final Map<String, dynamic> json = serializers.serializeWith(SignUpInfo.serializer, info);
  //   // TODO: Maybe a better way?
  //   // No passwords on firestore.
  //   json.remove('password');
  //   return usersRef.document(firebaseUser.uid).setData(json, SetOptions.merge);
  // }

  Future<Null> logout() async {
    await _auth.signOut();
    final googleSignout = _gSignIn.signOut();
  }

  Future<FirebaseUser> signInWithGoogle() async {
    GoogleSignInAccount googleUser = await _gSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    FirebaseUser user;
    try {
      user = await _auth.linkWithGoogleCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
    } catch(e) {
      user = await _auth.linkWithGoogleCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
    }
    return _db.collection('users').document(user.uid).setData({
      'name': user.displayName,
      'profilePic': user.photoUrl,
      'email': user.email,
      'isAnonymous': false,
      'provider': user.providerId,
    }, SetOptions.merge);
  }
}
