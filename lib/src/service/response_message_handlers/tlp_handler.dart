import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tlp_client/src/database/db_handler_priv.dart';
import 'package:tlp_client/src/utils/encryption.dart';
import 'package:tlp_client/tlp_client.dart';

Future<void> handlerTlpResponse(dynamic data) async {
  final tlpResponse = TlpResponse.fromJson(data);

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  Encryption encryption = Encryption();

  final encryptedFastPower = prefs.getString('fast_power');

  if (encryptedFastPower != null) {
    String fastPower = encryption.decryptMessage(encryptedFastPower);
    print("FAST POWER: $fastPower VS ANSWER ${tlpResponse.answer} ");
    if (fastPower != tlpResponse.answer) {
      if (kDebugMode) {
        print("WE DONT HAVE A MATCH ");
      }
      await Fluttertoast.showToast(
        msg: "Complaining",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 20,
        backgroundColor: Colors.red[300],
        textColor: Colors.white,
        fontSize: 16.0,
      );
      // send complaint to server
      // final complaintData = {
      //   'type': 'complaint',
      //   'data': {'fingerprint': tlpResponse.fingerprint},
      // };
      // final TlpClient client = TlpClient();
      // await client.initialize();
      // print("TO SEND COMPLAINT TO SERVER");
      // client.sendComplaint(complaintData);
    }
  }

  await saveTlpToDb(tlpResponse);
  await prefs.remove('fast_power');
}
