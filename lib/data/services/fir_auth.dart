import 'dart:async';

import 'package:chatty/models/serializers.dart';
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

  Future<FirebaseUser> signInWithGoogle() async {
    FirebaseUser firebaseUser = await _auth.currentUser();
    if (firebaseUser != null) return firebaseUser;
    // Attempt to get the currently authenticated user
    GoogleSignInAccount currentUser = _googleSignIn.currentUser;
    if (currentUser == null) {
      // Attempt to sign in without user interaction
      currentUser = await _googleSignIn.signInSilently();
    }
    if (currentUser == null) {
      // Force the user to interactively sign in
      currentUser = await _googleSignIn.signIn();
    }

    final GoogleSignInAuthentication auth = await currentUser.authentication;

    // Authenticate with firebase
    final FirebaseUser user = await _auth.signInWithGoogle(
      idToken: auth.idToken,
      accessToken: auth.accessToken,
    );

    pushUserInfo(user);

    assert(user != null);
    assert(!user.isAnonymous);

    return user;
  }

  Future signOutWithGoogle() async {
    // Sign out with firebase
    await _auth.signOut();
    // Sign out with google
    await _googleSignIn.signOut();
  }

  Future<void> pushUserInfo(FirebaseUser firebaseUser) async {
    User user = new User((b) => b
      ..email = firebaseUser.email
      ..isAnonymous = false
      ..userUid = firebaseUser.uid
      ..profilePic = firebaseUser.photoUrl
      ..provider = firebaseUser.providerId);
    return _db.collection('users')
        .document(firebaseUser.uid)
        .setData(serializers.serializeWith(User.serializer, user), SetOptions.merge);
  }
}