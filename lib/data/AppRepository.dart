import 'dart:async';

import 'package:chatty/models/email_login_info.dart';
import 'package:chatty/models/user.dart';
import 'package:chatty/data/services/fir_auth.dart';
import 'package:chatty/data/services/fir_chat.dart';

class AppRepository {
  final FirChat firChat;
  final FirAuth firAuth;
  AppRepository(this.firAuth, this.firChat);



}