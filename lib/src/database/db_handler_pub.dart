import 'package:tlp_client/src/database/database.dart';
import 'package:tlp_client/src/utils/encryption.dart';

final database = AppDatabase();
final Encryption encryption = Encryption();

class Database {
  final Encryption encryption = Encryption();

  Stream<List<TLPItem>> getSavedTlps() {
    return database.select(database.tLPItems).watch();
  }

  void listenForTLP({required void Function() onData}) {
    database.select(database.tLPItems).watchSingle().listen(
      (_) {
        onData();
      },
    );
  }
}
