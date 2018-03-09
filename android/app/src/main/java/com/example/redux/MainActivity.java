package com.example.redux;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;

import com.firebase.ui.auth.AuthUI;
import com.firebase.ui.auth.ErrorCodes;
import com.firebase.ui.auth.IdpResponse;
import com.google.firebase.auth.FirebaseAuth;

import java.util.Arrays;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  private static final int RC_SIGN_IN = 123;
  private static final String CHANNEL = "com.d4vinci.chatty";
  private static final String TAG = "FLUTTER_ACTIVITY";
  FirebaseAuth auth = FirebaseAuth.getInstance();
  MethodChannel channel;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    channel = new MethodChannel(getFlutterView(), CHANNEL);
            channel.setMethodCallHandler(
            new MethodChannel.MethodCallHandler() {
              @Override
              public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                if(methodCall.method.equals("startLogin")) {
                  startLogin();
                  result.success(null);
                } else {
                  result.notImplemented();
                }
              }
            }
    );
  }

  void startLogin() {
    if(auth.getCurrentUser() != null) {
      Intent firebaseUidIntent = AuthUI.getInstance()
              .createSignInIntentBuilder()
              .setAvailableProviders(Arrays.asList(
                      new AuthUI.IdpConfig.EmailBuilder().build(),
                      new AuthUI.IdpConfig.GoogleBuilder().build(),
                      new AuthUI.IdpConfig.PhoneBuilder().build()
              ))
              .setIsSmartLockEnabled(!BuildConfig.DEBUG, true)
              .build();
      startActivityForResult(firebaseUidIntent, RC_SIGN_IN);
    } else {
      // IDK
    }
  }

  protected void onActivityResult(int requestCode, int resultCode, Intent data) {
    super.onActivityResult(requestCode, resultCode, data);
    // RC_SIGN_IN is the request code you passed into startActivityForResult(...) when starting the sign in flow.
    if (requestCode == RC_SIGN_IN) {
      IdpResponse response = IdpResponse.fromResultIntent(data);

      // Successfully signed in
      if (resultCode == RESULT_OK) {
        // User signed in!
      } else {
        // Sign in failed
        if (response == null) {
          // User pressed back button
          return;
        }

        if (response.getError().getErrorCode() == ErrorCodes.NO_NETWORK) {
          // No internet connection :/
          return;
        }

        // Mysterious unknown
        Log.e(TAG, "Sign-in error: ", response.getError());
      }
    }
  }
}
