import 'dart:convert';
import 'dart:math';

import 'package:matrix/matrix.dart';

import '../db/database.dart';

class MatrixSession {
  final client = Client("iDichotic+");

  dynamic login(url, token) async {
    var pw = randomString(32);
    var user = randomString(8);
    await client.checkHomeserver(Uri.parse(url));
    await client.register(auth: AuthenticationToken(token: token), username: "dichotic_results_$user");
    await client.login(LoginType.mLoginPassword, identifier: AuthenticationUserIdentifier(user: user), password: pw);
  }

  dynamic join(String mxid) async {
    await client.startDirectChat(mxid);
  }

  dynamic sendResults(String roomId, Map<String, dynamic> data) async {
    var txnId = randomString(16);
    data['settings'] = database.select(database.preferences).getSingleOrNull();
    await client.sendMessage(roomId, "no.mmiv.dichotic.results", txnId, data);
  }

  dynamic dispose() {
    client.logout();
  }

  String randomString(int length) {
    var random = Random.secure();
    var values = List<int>.generate(length, (i) =>  random.nextInt(255));
    return base64UrlEncode(values);
  }
}