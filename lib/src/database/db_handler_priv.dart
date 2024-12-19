import 'package:tlp_client/src/database/database.dart';
import 'package:tlp_client/src/database/db_handler_pub.dart';
import 'package:tlp_client/tlp_client.dart';

Future<void> saveTlpToDb(TlpResponse tlp) async {
  final encryptedAnswer = encryption.encryptMessage(tlp.answer.toString());
  await database.into(database.tLPItems).insert(TLPItemsCompanion.insert(
        fingerprint: tlp.fingerprint,
        answerEnc: encryptedAnswer,
      ));
}
